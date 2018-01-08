package com.thinkgem.jeesite.modules.vehcile.web;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
/*import org.codehaus.xfire.XFire;
import org.codehaus.xfire.XFireFactory;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;*/
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.vehcile.entity.FrmCode;
import com.thinkgem.jeesite.modules.vehcile.entity.Machine;
import com.thinkgem.jeesite.modules.vehcile.entity.QueryLog;
import com.thinkgem.jeesite.modules.vehcile.entity.Vehicle;
import com.thinkgem.jeesite.modules.vehcile.service.QuerySerivce;
import com.thinkgem.jeesite.modules.vehcile.util.CyjgWebservice;
import com.thinkgem.jeesite.modules.vehcile.util.DateUtil;
import com.thinkgem.jeesite.modules.vehcile.util.MD5Util;


@Controller
@RequestMapping("${adminPath}/vehicle")
@Configuration
@PropertySource("classpath:jcz.properties")
public class QueryContoller extends BaseController {

	@Resource
	private QuerySerivce querySerivce;
	@Autowired
    private Environment env;
	
	@Autowired
	private OfficeService officeService;
	
	@RequestMapping("saveStatus")
	public String saveStatus(Model model) {
		Office office = UserUtils.getOfficeList().get(0);
		model.addAttribute("office", office);
		return "modules/vehicle/officeForm_saveStatus";
	}
	
	@RequestMapping("updateOffice")
	public String updateOffice(HttpServletRequest req,HttpServletResponse resp,Office office,Model model) {
		int i = officeService.updateOfficeSaveStatus(office);
		Office office1 = UserUtils.getOfficeList().get(0);
		model.addAttribute("office", office1);
		model.addAttribute("updateStatus",i);
		return "modules/vehicle/officeForm_saveStatus";
	}
	
	@RequestMapping("print_auto")
	public String print_auto(Model model) {
		Office office = UserUtils.getOfficeList().get(0);
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		model.addAttribute("office", office);
		return "modules/vehicle/artificialPrint_auto";
	}
	
	@RequestMapping("print")
	public String print(Model model) {
		Office office = UserUtils.getOfficeList().get(0);
		User user = UserUtils.getUser();
		model.addAttribute("user", user);
		model.addAttribute("office", office);
		return "modules/vehicle/artificialPrint";
	}
	
	@RequestMapping("insertVeh")
	public void insertVeh(HttpServletRequest req,HttpServletResponse resp,Vehicle veh) {
		Office office = UserUtils.getOfficeList().get(0);
		//只有该用户部门状态为1进行数据写入和更新操作
		if("1".equals(office.getSaveStatus())){
			if(veh!=null){
				if("轿车".equals(veh.getCllx())){
					veh.setCllx("小型轿车");
				}
				FrmCode frmCode1 = new FrmCode(); 
				frmCode1.setXtlb("00");
				frmCode1.setDmlb("1004");
				frmCode1.setDmsm1(veh.getCllx());
				frmCode1 = querySerivce.getFrmCodeByWhere(frmCode1);
				if(frmCode1!=null){
					veh.setCllx(frmCode1.getDmz());
				}
				FrmCode frmCode = new FrmCode(); 
				frmCode.setXtlb("00");
				frmCode.setDmlb("1003");
				frmCode.setDmsm1(veh.getSyxz());
				frmCode = querySerivce.getFrmCodeByWhere(frmCode);
				if(frmCode!=null){
					veh.setSyxz(frmCode.getDmz());
				}
			}
			veh.setJyjgbh(office.getCode());
			Vehicle vehTemp = querySerivce.getVehByWhere1(veh);
			if(vehTemp!=null){
				int i = querySerivce.updateVehByWhere(veh);
			}else{
				int i = querySerivce.insertVeh(veh);
			}
		}
		
		
	}
	/**
	 * 打印
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("pzPrintMx")
	public ModelAndView pzPrintMx(HttpServletRequest req,HttpServletResponse resp){
		
		String hpzl = req.getParameter("hpzl");
		String ybhm = req.getParameter("ybhm");
		String brstatus = req.getParameter("brstatus");
		String lxdh = req.getParameter("lxdh");
		String clsbdh = req.getParameter("clsbdh");
		String hphm ="";
		String xm  = "";
		String hpzlmc = "";
		String lxdz = "";
		String dlr = "";
		String ccrq = "";
		String ccdjrq = "";
		String cllx = "";
		String syxz = "";
		try {
			hphm = java.net.URLDecoder.decode(req.getParameter("hphm"),"UTF-8").toUpperCase();
			xm = java.net.URLDecoder.decode(req.getParameter("xm"),"UTF-8");
			hpzlmc = java.net.URLDecoder.decode(req.getParameter("hpzlmc"),"UTF-8");
			lxdz = java.net.URLDecoder.decode(req.getParameter("lxdz"),"UTF-8");
			dlr = java.net.URLDecoder.decode(req.getParameter("dlr"),"UTF-8");
			
			ccrq = req.getParameter("ccrq");
			if(ccrq!=null&&!"".equals(ccrq)){
				ccrq = DateUtil.strToDate(DateUtil.strToDate(ccrq));
			}
			ccdjrq = req.getParameter("ccdjrq");
			if(ccdjrq!=null&&!"".equals(ccdjrq)){
				ccdjrq = DateUtil.strToDate(DateUtil.strToDate(ccdjrq));
			}
			String cllxTemp = req.getParameter("cllx");
			FrmCode frmCode = new FrmCode(); 
			if(cllxTemp!=null && !"".equals(cllxTemp)){
				frmCode.setXtlb("00");
				frmCode.setDmlb("1004");
				frmCode.setDmz( cllxTemp);
				frmCode = querySerivce.getFrmCodeByWhere(frmCode);
				cllx = frmCode.getDmsm1();
			}
			String syxzTemp = req.getParameter("syxz");
			FrmCode frmCode1 = new FrmCode(); 
			if(syxzTemp!=null && !"".equals(syxzTemp)){
				frmCode1.setXtlb("00");
				frmCode1.setDmlb("1003");
				frmCode1.setDmz( syxzTemp);
				frmCode1 = querySerivce.getFrmCodeByWhere(frmCode1);
				syxz = frmCode1.getDmsm1();
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("hpzl", hpzl==null?"":hpzl);
		mv.addObject("hphm", hphm==null?"":hphm);
		mv.addObject("xm", xm==null?"":xm);
		mv.addObject("hpzlmc", hpzlmc==null?"":hpzlmc);
		mv.addObject("ybhm", ybhm==null?"":ybhm);
		mv.addObject("lxdh", lxdh==null?"":lxdh);
		mv.addObject("lxdz", lxdz==null?"":lxdz);
		mv.addObject("dlr", dlr==null?"":dlr);
		mv.addObject("clsbdh", clsbdh==null?"":clsbdh);
		mv.addObject("ccrq", ccrq==null?"":ccrq);
		mv.addObject("ccdjrq", ccdjrq==null?"":ccdjrq);
		mv.addObject("cllx", cllx==null?"":cllx);
		mv.addObject("syxz", syxz==null?"":syxz);
		if("1".equals(brstatus)){
			mv.setViewName("pzPrintMx");
		}else{
			mv.setViewName("pzPrintMx_dlr");
		}
		
		
		return mv;
	}
	
	@RequestMapping(value="getHpzlList",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String CheckResult(){
		Properties prop=new Properties();  
		String jyjgdz = "";
		try {
			prop.load(new InputStreamReader(QueryContoller.class.getClassLoader().getResourceAsStream("jcz.properties"), "UTF-8"));  
			jyjgdz = prop.getProperty("jyjgdz");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//String jyjgdz = "山东泰安新泰市翟镇工业园区";
		String jyjglxdh = env.getProperty("jyjglxdh");
		String jyjgyb = env.getProperty("jyjgyb");
		return "{\"jyjgdz\":\""+jyjgdz+"\",\"jyjglxdh\":\""+jyjglxdh+"\",\"jyjgyb\":\""+jyjgyb+"\"}";
	}
	/**
	 * 显示操作键盘
	 * @return
	 */
	@RequestMapping("showOsk")
	public String showOsk() {
		String cmd = "osk";  
		Runtime run = Runtime.getRuntime();//返回与当前 Java 应用程序相关的运行时对象  
        try {
			Process p = run.exec(cmd);
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
        return null;
	}
	/**
	 * 查询机动车
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("qeuryVechile")
	@ResponseBody
	public Map<String,String> qeuryVechile(HttpServletRequest req,HttpServletResponse resp){
		
		String code = "" ;
		String message  = "" ;
		String ybhm = "";
		String syr = "";
		
		Map<String,String> map = new HashMap<String, String>();

		String hpzl = req.getParameter("hpzl");
		String hphm = req.getParameter("hphm");
		String hphm_input = req.getParameter("hphm_input").toUpperCase();
		String djh = req.getParameter("cjh");
		String type = req.getParameter("type");
		hphm_input = hphm_input.toUpperCase();
		
		Vehicle veh = new Vehicle();
		veh.setHpzl(hpzl);
		veh.setHphm(hphm+hphm_input);
		veh.setClsbdh(djh);
		veh.setType(type);
		
		Office office = UserUtils.getOfficeList().get(0);
		veh.setJyjgbh(office.getCode());
		
		Vehicle vheTemp = querySerivce.getVehByWhere(veh);
		//1.首先 查询本地是否已经存在该数据
		//2.有，则不调用18C49
		//3.无，则调用18C49，并将数据写入到本地库，以作备用
		String glbm = "";
		String clsbdh = "";
		String cllx = "";
		String syxz = "";
		String ccrq = "";
		String ccdjrq = "";
		if(vheTemp==null){
			try {
				Vehicle recVeh = this.ex18C49(hpzl, hphm+hphm_input, djh);
				//System.out.println(recVeh.getHphm());
				code = recVeh.getCode();
				if("1".equals(code)){
					recVeh.setHphm(hphm+hphm_input);
					recVeh.setJyjgbh(office.getCode());
					int i = querySerivce.insertVeh(recVeh);
				}
				message = recVeh.getMessage();
				syr = recVeh.getSyr();
				glbm = recVeh.getZzxzqh();
				clsbdh = recVeh.getClsbdh();
				cllx = recVeh.getCllx();
				syxz = recVeh.getSyxz();
				ccrq = recVeh.getCcrq();
				ccdjrq = recVeh.getCcdjrq();
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
				code = "-1";
				message = e2.getMessage();
			}
			
			if((hphm+hphm_input).startsWith("鲁J")){
				ybhm = "271000";
			}
			if("".equals(ybhm)){
				if(!"".equals(glbm)){
					ybhm = querySerivce.getYzbmByXzqh(glbm);
				}
				
			}
			map.put("code", code);
			map.put("message", message);
			map.put("syr", syr);
			map.put("ybhm", ybhm==null?"":ybhm);
			map.put("lxdh", "");
			map.put("lxdz", "");
			map.put("dlr", "");
			map.put("clsbdh", clsbdh);
			
			map.put("cllx", cllx);
			map.put("syxz", syxz);
			map.put("ccrq", ccrq);
			map.put("ccdjrq", ccdjrq);
		}else{
			System.out.println("");
			if(vheTemp.getYzbm()==null||"".equals(vheTemp.getYzbm())){
				if((hphm+hphm_input).startsWith("鲁J")){
					ybhm = "271000";
				}else{
					ybhm = querySerivce.getYzbmByXzqh(vheTemp.getZzxzqh());
				}
				map.put("ybhm", ybhm==null?"":ybhm);
			}else{
				map.put("ybhm", vheTemp.getYzbm()==null?"":vheTemp.getYzbm());
			}
			map.put("code","1");
			map.put("syr", vheTemp.getSyr()==null?"":vheTemp.getSyr());
			
			map.put("lxdh", vheTemp.getLxdh()==null?"":vheTemp.getLxdh());
			map.put("lxdz", vheTemp.getLxdz()==null?"":vheTemp.getLxdz());
			map.put("dlr", vheTemp.getDlr()==null?"":vheTemp.getDlr());
			map.put("clsbdh", vheTemp.getClsbdh());
			map.put("message", message);
			
			map.put("cllx", vheTemp.getCllx());
			map.put("syxz", vheTemp.getSyxz());
			map.put("ccrq", vheTemp.getCcrq());
			map.put("ccdjrq", vheTemp.getCcdjrq());
		}
		FrmCode frmCode = new FrmCode(); 
		String syxzMc = "";
		String cllxMc = "";
		if(map.get("cllx")!=null && !"".equals(map.get("cllx"))){
			frmCode.setXtlb("00");
			frmCode.setDmlb("1004");
			frmCode.setDmz( map.get("cllx"));
			frmCode = querySerivce.getFrmCodeByWhere(frmCode);
			cllxMc = frmCode.getDmsm1();
		}
		if(map.get("syxz")!=null && !"".equals(map.get("syxz"))){
			FrmCode frmCode1 = new FrmCode();
			frmCode1.setXtlb("00");
			frmCode1.setDmlb("1003");
			frmCode1.setDmz( map.get("syxz"));
			frmCode1 = querySerivce.getFrmCodeByWhere(frmCode1);
			syxzMc = frmCode1.getDmsm1();
		}
		map.put("cllxmc", cllxMc);
		map.put("syxzmc", syxzMc);
		return map;
	}
	/**
	 * 查询机动车检验状态
	 * @param req
	 * @param resp
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping("qeuryCheckResult")
	@ResponseBody
	public Map<String,String> qeuryCheckResult(HttpServletRequest req,HttpServletResponse resp) throws UnsupportedEncodingException{
		
		//String code = "" ;
		String message  = "" ;
		String shbtgyy  = "" ;
		
		String hpzl = req.getParameter("hpzl");
		String hphm = req.getParameter("hphm");
		String hphm_input = req.getParameter("hphm_input");
		hphm_input = hphm_input.toUpperCase();
		/**
		 * 1.检查IP和检验机构编号是否生效
		 */
		String ip = null;
		String jyjgbh = env.getProperty("jyjgbh");
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
		String keyCode = MD5Util.MD5(ip+"taian_web"+jyjgbh);
		Machine machine = new Machine();
		machine.setIp(ip);
		machine.setJyjgbh(jyjgbh);
		machine.setKeycode(keyCode);
		Machine machine1 = querySerivce.querySeKey(machine);
		if(machine1!=null){
			/**
			 * 2.检查是否间隔10分钟
			 */
			QueryLog queryLog = new QueryLog();
			queryLog.setHphm(hphm+hphm_input);
			queryLog.setHpzl(hpzl);
			QueryLog queryLog1 = querySerivce.getQueryLog(queryLog);
			if(queryLog1!=null){ 		//存在数据
				Date date2 = new Date();
				long minutes = (date2.getTime()-queryLog1.getLogtime().getTime())/(1000*60);
				long jgsj = Long.parseLong(env.getProperty("jgsj"));
				if(minutes<jgsj){		//存在数据 时间间隔不够
					message = "查询太频繁，每次查询间隔为五分钟!";
				}else{					//存在数据 时间间隔满足
					try {
						
						message = this.ex18C48(hpzl, hphm+hphm_input);
						/**
						 * 更新查询日志
						 * 
						 */
						queryLog.setLogtime(new Date());
						int i = querySerivce.updateQueryLog(queryLog);
					} catch (Exception e) {
						message = e.getMessage();
						e.printStackTrace();
					}
				}
			}else{	//不存在日志
				try {
					message = this.ex18C48(hpzl, hphm+hphm_input);
					/**
					 * 写入日志
					 * 
					 */
					int i = querySerivce.insertQueryLog(queryLog);
				} catch (Exception e) {
					message = e.getMessage();
					e.printStackTrace();
				}
				
			}
			
		}else{
			message = "设备未注册，请先注册！";
		}
		 
	    Map<String,String> map = new HashMap<String, String>();
	    map.put("message", message);
	    map.put("shbtgyy", shbtgyy);
	    
		return map;
	}
	/**
	 * 执行接口查询机动车检验状态
	 * @param hpzl
	 * @param hphm
	 * @return
	 * @throws Exception
	 */
	public String ex18C48(String hpzl,String hphm) throws Exception{
		StringBuffer resultXml = new StringBuffer();
		resultXml.append("<?xml version=\"1.0\" encoding=\"GBK\"?><root><QueryCondition><jylsh></jylsh>"
				+ "<jyjgbh>"+env.getProperty("jyjgbh")+"</jyjgbh><hphm>"+hphm
						+ "</hphm><hpzl>"+hpzl
						+ "</hpzl><cxzt></cxzt><fhzdjls>1</fhzdjls></QueryCondition></root>");
		System.out.println("接口地址："+env.getProperty("url"));
        System.out.println("系统类别："+env.getProperty("xtlb"));
        System.out.println("接口序列号："+env.getProperty("jkxlh"));
        System.out.println("接口ID："+env.getProperty("jkid"));
        System.out.println("请求XML："+resultXml.toString());
        
       /* Service service= new ObjectServiceFactory().create(CyjgWebservice.class);
		XFire xFire = XFireFactory.newInstance().getXFire();
		XFireProxyFactory factory = new XFireProxyFactory(xFire);
		CyjgWebservice impl = (CyjgWebservice) factory.create(service, env.getProperty("url"));
        String result = impl.queryObjectOut(env.getProperty("xtlb"),env.getProperty("jkxlh"),env.getProperty("jkid"),resultXml.toString());
		*/
        
        String result = null;
        result = URLDecoder.decode(result, "UTF-8");
		
		System.out.println("响应XML:"+result);
		Document docrec;
		docrec = DocumentHelper.parseText(result);
		List<?> recList = docrec.selectNodes("root//"+"head");
		Element recMess = (Element) recList.get(0);
		String code = recMess.elementText("code")==null?"":recMess.elementText("code");
		String message = recMess.elementText("message")==null?"":recMess.elementText("message");
		String shbtgyy = "";
		if("1".equals(code)){
			Document docruq;
			docruq = DocumentHelper.parseText(result);
			List<?> ruqList = docruq.selectNodes("root//"+"vehispara");
			if(ruqList!=null && ruqList.size()>0){
				Element vehispara = (Element) ruqList.get(0);
				String shjg = vehispara.elementText("shjg")==null?"":vehispara.elementText("shjg");
				shbtgyy = recMess.elementText("shbtgyy")==null?"":recMess.elementText("shbtgyy");
				if("0".equals(shjg)){
					message = "外观未审核"; 
				}
				else if("1".equals(shjg)){
					message = "正在外观审核"; 
				}
				else if("2".equals(shjg)){
					message = "外观审核通过"; 
				}
				else if("3".equals(shjg)){
					message = "外观审核不通过"; 
				}
				else if("4".equals(shjg)){
					message = "您的爱车正在上线检测或等待车管所审核，请耐心等待"; 
				}
				else if("5".equals(shjg)){
					message = "您的爱车正在接受车管所审核中，请稍等5-10分钟后查询"; 
				}
				else if("6".equals(shjg)){
					message = "核发审核通过"; 
				}
				else if("7".equals(shjg)){
					message = "您的爱车未通过审核，祥情请到3号窗口咨询"; 
				}
				else if("8".equals(shjg)){
					message = "您的爱车审核通过，请带好行驶证副页到4号窗口打印合格标志"; 
				}
				else if("9".equals(shjg)){
					message = "已打印"; 
				}
				else if("a".equals(shjg)){
					message = "您的爱车可能处于违法未处理/逾期未检验/锁定/查封等状态，请先到交通违法自助处理机上确认已经处理了所有交通违法，再到3号窗口咨询"; 
				}
			}else{
				message = "未查询到结果，请检查号牌号码与号牌种类是否正确输入！";
			}
			
		}
		return message+shbtgyy;
	}
	/**
	 * 执行接口获取 车辆信息
	 * @param hpzl
	 * @param hphm
	 * @param djh
	 * @return
	 * @throws Exception
	 */
	public Vehicle ex18C49(String hpzl,String hphm,String djh) throws Exception{
		StringBuffer resultXml = new StringBuffer();
		Office office = UserUtils.getOfficeList().get(0);
		
		
		resultXml.append("<?xml version=\"1.0\" encoding=\"GBK\"?><root><QueryCondition><jylsh></jylsh>"
				+ "<jyjgbh>"+office.getCode()+"</jyjgbh><hphm>"+hphm
						+ "</hphm><hpzl>"+hpzl
						+ "</hpzl><clsbdh>"+djh+"</clsbdh></QueryCondition></root>");
        
        /*Service service= new ObjectServiceFactory().create(CyjgWebservice.class);
		XFire xFire = XFireFactory.newInstance().getXFire();
		XFireProxyFactory factory = new XFireProxyFactory(xFire);
		CyjgWebservice impl = (CyjgWebservice) factory.create(service, env.getProperty("url"));
        String result = impl.queryObjectOut(env.getProperty("xtlb"),office.getRemarks(),"18C49",resultXml.toString());*/
		 String result = null ;
		result = URLDecoder.decode(result, "UTF-8");
		//System.out.println("响应XML:"+result);
		Document docrec;
		docrec = DocumentHelper.parseText(result);
		List<?> recList = docrec.selectNodes("root//"+"head");
		Element recMess = (Element) recList.get(0);
		String code = recMess.elementText("code")==null?"":recMess.elementText("code");
		String message = recMess.elementText("message")==null?"":recMess.elementText("message");
		String fzjg = "";
		String syr = "";
		Vehicle veh = new Vehicle();
		if("1".equals(code)){
			Document docruq;
			docruq = DocumentHelper.parseText(result);
			List<?> ruqList = docruq.selectNodes("root//"+"vehispara");
			if(ruqList!=null && ruqList.size()>0){
				Element vehispara = (Element) ruqList.get(0);
				syr = vehispara.elementText("syr")==null?"":vehispara.elementText("syr");
				fzjg = vehispara.elementText("fzjg")==null?"":vehispara.elementText("fzjg");
				veh.setCllx(vehispara.elementText("cllx")==null?"":vehispara.elementText("cllx"));
				veh.setClsbdh(vehispara.elementText("clsbdh")==null?"":vehispara.elementText("clsbdh"));
				veh.setClyt(vehispara.elementText("clyt")==null?"":vehispara.elementText("clyt"));
				veh.setFzjg(vehispara.elementText("fzjg")==null?"":vehispara.elementText("fzjg"));
				veh.setHphm(vehispara.elementText("hphm")==null?"":vehispara.elementText("hphm"));
				veh.setHpzl(vehispara.elementText("hpzl")==null?"":vehispara.elementText("hpzl"));
				veh.setSyr(syr); 
				veh.setSyxz(vehispara.elementText("syxz")==null?"":vehispara.elementText("syxz"));
				veh.setYtxz(vehispara.elementText("ytsx")==null?"":vehispara.elementText("ytsx"));
				veh.setYxqz(vehispara.elementText("yxqz")==null?"":vehispara.elementText("yxqz"));
				veh.setZzxzqh(vehispara.elementText("xzqh")==null?"":vehispara.elementText("xzqh"));
				if(vehispara.elementText("ccrq")!=null&&!"".equals(vehispara.elementText("ccrq"))){
					String[] ccrqArr = vehispara.elementText("ccrq").split(" ");
					veh.setCcrq(ccrqArr[0]);
				}
				if(vehispara.elementText("ccdjrq")!=null&&!"".equals(vehispara.elementText("ccdjrq"))){
					String[] ccdjrqArr = vehispara.elementText("ccdjrq").split(" ");
					veh.setCcdjrq(ccdjrqArr[0]);
				}
			}else if ("$E".equals(code)&"服务器端提示信息：java.lang.Exception: 查询请求已发送，请确认号牌信息无误后，等待5-10秒再试！".equals(message)) {
					Thread.sleep(12000);
				 	//result = impl.queryObjectOut(env.getProperty("xtlb"),env.getProperty("jkxlh"),"18C49",resultXml.toString());
					result = URLDecoder.decode(result, "UTF-8");
					//System.out.println("响应XML:"+result);
					docrec = DocumentHelper.parseText(result);
					recList = docrec.selectNodes("root//"+"head");
					recMess = (Element) recList.get(0);
					code = recMess.elementText("code")==null?"":recMess.elementText("code");
					message = recMess.elementText("message")==null?"":recMess.elementText("message");
					if("1".equals(code)){
						docruq = DocumentHelper.parseText(result);
						ruqList = docruq.selectNodes("root//"+"vehispara");
						if(ruqList!=null && ruqList.size()>0){
							Element vehispara = (Element) ruqList.get(0);
							syr = vehispara.elementText("syr")==null?"":vehispara.elementText("syr");
							fzjg = vehispara.elementText("fzjg")==null?"":vehispara.elementText("fzjg");
							veh.setCllx(vehispara.elementText("cllx")==null?"":vehispara.elementText("cllx"));
							veh.setClsbdh(vehispara.elementText("clsbdh")==null?"":vehispara.elementText("clsbdh"));
							veh.setClyt(vehispara.elementText("clyt")==null?"":vehispara.elementText("clyt"));
							veh.setFzjg(vehispara.elementText("fzjg")==null?"":vehispara.elementText("fzjg"));
							veh.setHphm(vehispara.elementText("hphm")==null?"":vehispara.elementText("hphm"));
							veh.setHpzl(vehispara.elementText("hpzl")==null?"":vehispara.elementText("hpzl"));
							veh.setSyr(syr); 
							veh.setSyxz(vehispara.elementText("syxz")==null?"":vehispara.elementText("syxz"));
							veh.setYtxz(vehispara.elementText("ytsx")==null?"":vehispara.elementText("ytsx"));
							veh.setYxqz(vehispara.elementText("yxqz")==null?"":vehispara.elementText("yxqz"));
							veh.setZzxzqh(vehispara.elementText("xzqh")==null?"":vehispara.elementText("xzqh"));
							veh.setCcrq(vehispara.elementText("ccrq")==null?"":vehispara.elementText("ccrq"));
							veh.setCcdjrq(vehispara.elementText("ccdjrq")==null?"":vehispara.elementText("ccdjrq"));
						}else{
							code = "0";
							message = "未查询到结果，请检查号牌号码与号牌种类是否正确输入！";
						}
					}
			}else{
				code = "0";
				message = "未查询到结果，请检查号牌号码与号牌种类是否正确输入！";
			}
			
		}
		veh.setCode(code);
		veh.setMessage(message);
		
		/*Vehicle veh = new Vehicle();
		veh.setCllx("1");
		veh.setClsbdh("3333");
		veh.setClyt("3");
		veh.setFzjg("4");
		veh.setHphm("鲁A54321");
		veh.setHpzl("01");
		veh.setSyr("赵国华"); 
		veh.setSyxz("1");
		veh.setYtxz("1");
		veh.setYxqz("2016-12-31");
		veh.setZzxzqh("371626");
		veh.setCode("1");
		veh.setMessage("成功");
		veh.setCcrq("2017-01-01");
		veh.setCcdjrq("2017-01-02");
		veh.setCllx("H28");
		veh.setSyxz("P");
		veh.setZzxzqh("371122");*/
		
		
		return veh;
	}
	@RequestMapping("checkMachine")
	@ResponseBody
	public boolean checkMachine(){
		String ip = null;
		String jyjgbh = UserUtils.getOfficeList().get(0).getCode();
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
		String keyCode = MD5Util.MD5(ip+"taian_web"+jyjgbh);
		Machine machine = new Machine();
		machine.setIp(ip);
		machine.setJyjgbh(jyjgbh);
		machine.setKeycode(keyCode);
		Machine machine1 = querySerivce.querySeKey(machine);
		if(machine1!=null){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * get postcode by hphm
	 * @return
	 */
	@RequestMapping("getPostCodeByHphm")
	@ResponseBody
	public String getPostCodeByHphm(HttpServletRequest req,HttpServletResponse resp){
		String hphm = req.getParameter("hphm");
		return querySerivce.getPostCodeByHphm(hphm);
	}
	
	
	@RequestMapping("vehList")
	public String list(Vehicle veh, HttpServletRequest request, HttpServletResponse response, Model model) {
		FrmCode frmCode = new FrmCode();
		frmCode.setDmlb("1007");
		frmCode.setXtlb("00");
		List<FrmCode> frmCodeList = querySerivce.getFrmCodeListByWhere(frmCode);
		model.addAttribute("frmCodeList", frmCodeList);
		User user = UserUtils.getUser();
		String isAdmin = "1";
		if(!user.isAdmin()){
			Office office = UserUtils.getOfficeList().get(0);
			veh.setJyjgbh(office.getCode());
			isAdmin = "0";
		}
        Page<Vehicle> page = querySerivce.findPage(new Page<Vehicle>(request, response), veh); 
        model.addAttribute("page", page);
        model.addAttribute("isAdmin", isAdmin);
		return "modules/vehicle/vehList";
	}
	
	@RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) throws Exception {
		ImportExcel ei;
		Office office = UserUtils.getOfficeList().get(0);
		try {
			ei = new ImportExcel(file, 1, 0);
			List<Vehicle> list = ei.getVehList();
			for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				Vehicle vehicle = (Vehicle) iterator.next();
				if(vehicle!=null){
					FrmCode frmCode1 = new FrmCode(); 
					frmCode1.setXtlb("00");
					frmCode1.setDmlb("1007");
					frmCode1.setDmsm1(vehicle.getHpzl());
					frmCode1 = querySerivce.getFrmCodeByWhere(frmCode1);
					if(frmCode1!=null&&frmCode1.getDmz()!=null){
						vehicle.setHpzl(frmCode1.getDmz());
					}else{
						throw new Exception("车牌号："+vehicle.getHphm()+"对应的号牌种类存在问题，未匹配正确的号牌种类，请检查！传入的号牌种类为："+vehicle.getHpzl());
					}
					vehicle.setJyjgbh(office.getCode());
				}
				Vehicle vehTemp = querySerivce.getVehByWhere1(vehicle);
				
				if(vehTemp!=null){
					int i = querySerivce.updateVehByWhere(vehicle);
				}else{
					int i = querySerivce.insertVeh(vehicle);
				}
				
			}
			addMessage(redirectAttributes, "已成功导入 "+list.size()+"条数据");
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:" + adminPath + "/vehicle/vehList?repage";
    }
	@RequestMapping(value = "delete")
	public String delete(Vehicle veh,  RedirectAttributes redirectAttributes) {
		querySerivce.deleteVehicle(veh);
		addMessage(redirectAttributes, "删除车辆信息成功");
		return "redirect:" + adminPath + "/vehicle/vehList?repage";
	}
	
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Vehicle veh, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			Office office = UserUtils.getOfficeList().get(0);
            String fileName = "车辆数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xls";
            veh.setJyjgbh(office.getCode());
            List<Vehicle> vehList = querySerivce.getVehList(veh);
    		new ExportExcel("车辆数据", Vehicle.class).setDataList(vehList).write(response, fileName).dispose();;
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/vehicle/vehList?repage";
    }
    
    @RequestMapping(value = "deleteByIds", method=RequestMethod.POST)
    @ResponseBody
    public String deleteByIds(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
    	try {
    	String ids = request.getParameter("vehIds");
    	querySerivce.deleteByIds(ids);
    	return "1";
    	} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
    }
    
}
