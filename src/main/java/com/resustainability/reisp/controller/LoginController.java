package com.resustainability.reisp.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.resustainability.reisp.common.CommonMethods;
import com.resustainability.reisp.common.DateForUser;
import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.Department;
import com.resustainability.reisp.model.Plant;
import com.resustainability.reisp.model.Project;
import com.resustainability.reisp.model.ProjectLocation;
import com.resustainability.reisp.model.RoleMapping;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.DepartmentService;
import com.resustainability.reisp.service.LocationService;
import com.resustainability.reisp.service.PlantService;
import com.resustainability.reisp.service.ProjectService;
import com.resustainability.reisp.service.RoleMappingService;
import com.resustainability.reisp.service.UserService;
import com.resustainability.reisp.controller.LoginController;
import com.resustainability.reisp.dao.UserDao;
@Controller
public class LoginController {
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    } 
	Logger logger = Logger.getLogger(LoginController.class);
	@Autowired
	UserService service;
	
	@Autowired
	UserService service2;
	 
	@Autowired
	LocationService service3;

	   @Autowired
	    PlantService service4;
	   @Autowired
	    DepartmentService service_dept;
	@Autowired
	ProjectService service5;
	
	@Value("${Logout.Message}")
	private String logOutMessage;
	
	@Value("${Login.Form.Invalid}")
	public String invalidUserName;
	
	
	@Value("${common.error.message}")
	public String commonError;
	
	@RequestMapping(value = "/", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView basePage(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
		ModelAndView model = new ModelAndView(PageConstants.login);
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model; 
	}
	@RequestMapping(value = "/q", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView proxy(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
		ModelAndView model = new ModelAndView(PageConstants.proxy);
		try {
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping(value = "/login", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView login(@ModelAttribute User user, HttpSession session,HttpServletRequest request,RedirectAttributes attributes) {
		ModelAndView model = new ModelAndView(PageConstants.login);
		User userDetails = null;
		try {
		
			if(!StringUtils.isEmpty(user) && !StringUtils.isEmpty(user.getUser_id()) && !StringUtils.isEmpty(user.getPassword())){
				userDetails = service.validateUser(user);
				if(!StringUtils.isEmpty(userDetails)) {
						
						/// USER BASIC SESSION DATA
						session.setAttribute("user", userDetails);
						session.setAttribute("ID", userDetails.getId());
						session.setAttribute("USER_ID", userDetails.getUser_id());
						session.setAttribute("USER_NAME", userDetails.getUser_name());
						session.setAttribute("NUMBER", userDetails.getContact_number());
						session.setAttribute("USER_EMAIL", userDetails.getEmail_id());
						session.setAttribute("BASE_ROLE", userDetails.getBase_role());
						session.setAttribute("BASE_SBU", userDetails.getBase_sbu());
						session.setAttribute("BASE_PROJECT", userDetails.getProject_name());
						session.setAttribute("BASE_DEPARTMENT", userDetails.getBase_department());
						session.setAttribute("BASE_PROJECT_CODE", userDetails.getBase_project());
						attributes.addFlashAttribute("welcome", "welcome "+userDetails.getUser_name());
						if("Admin".equals(userDetails.getBase_role())) {
							model.setViewName("redirect:/home");
						}else {
							model.setViewName("redirect:/form/capex");
						}
						
				}else{
					model.addObject("invalidEmail",invalidUserName);
					model.setViewName(PageConstants.newUserLogin);
					List<Plant> projectsList = service4.getPlantsList(null);
					model.addObject("projectsList", projectsList);
					List<User> usersList = service2.getUsersList(null);
					model.addObject("usersList", usersList);
					  List<Department> departmentList= service_dept.getDepartmentsList(null);
			            model.addObject("departmentList", departmentList);
			            
					List<Project> sbuList = service5.getSBUsList(null);
					model.addObject("sbuList", sbuList);
				}
			}else {
				model.addObject("message", "");
				model.setViewName(PageConstants.login);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model; 
	}
	
	
	@RequestMapping(value = "/add-new-user-form", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView addUserForm(@ModelAttribute User obj,RedirectAttributes attributes,HttpSession session) {
		boolean flag = false;
		String userId = null;
		String userName = null;
		ModelAndView model = new ModelAndView();
		try {
			model.setViewName(PageConstants.newUserLogin);
			List<Plant> projectsList = service4.getPlantsList(null);
			model.addObject("projectsList", projectsList);
			List<User> usersList = service2.getUsersList(null);
			model.addObject("usersList", usersList);
			List<Map<String, String>> simpleUsers = new ArrayList<>();

			for (User u : usersList) {

			    Map<String, String> map = new HashMap<>();

			    map.put("user_id", u.getUser_id());      // make sure getter exists
			    map.put("email_id", u.getEmail_id());    // make sure getter exists

			    simpleUsers.add(map);
			}

			ObjectMapper mapper = new ObjectMapper();
			String usersJson = mapper.writeValueAsString(simpleUsers);

			model.addObject("usersJson", usersJson);   // if using ModelAndView
			
			  List<Department> departmentList= service_dept.getDepartmentsList(null);
	            model.addObject("departmentList", departmentList);
	            
			List<Project> sbuList = service5.getSBUsList(null);
			model.addObject("sbuList", sbuList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/add-new-user", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView addUserFormMaster(@ModelAttribute User obj,RedirectAttributes attributes,HttpSession session) {
		boolean flag = false;
		String userId = null;
		String userName = null;
		User userDetails = null;
		ModelAndView model = new ModelAndView();
		try {
			model.setViewName("redirect:/login");
			userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			obj.setCreated_by(obj.getUser_id());
			obj.setStatus("Active");
			obj.setBase_role("User");
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
		    String dt = formatter.format(new Date());
			String endDate = DateForUser.date();
			obj.setEnd_date(endDate);
			obj.setCreated_by(obj.getUser_id());
			obj.setCreated_date(dt);
			flag = service.addUser(obj);
			if(flag == true) {
				//attributes.addFlashAttribute("success", "User Added Succesfully.");
				userDetails = service.validateUser(obj);
				if(!StringUtils.isEmpty(userDetails)) {
					//if((userDetails.getSession_count()) == 0) {
						model.setViewName("redirect:/home");
											/// USER BASIC SESSION DATA
						session.setAttribute("user", userDetails);
						session.setAttribute("ID", userDetails.getId());
						session.setAttribute("USER_ID", userDetails.getUser_id());
						session.setAttribute("USER_NAME", userDetails.getUser_name());
						session.setAttribute("USER_EMAIL", userDetails.getEmail_id());
						session.setAttribute("BASE_ROLE", userDetails.getBase_role());
						session.setAttribute("BASE_SBU", userDetails.getBase_sbu());
						session.setAttribute("BASE_PROJECT", userDetails.getProject_name());
						session.setAttribute("BASE_DEPARTMENT", userDetails.getBase_department());
						session.setAttribute("BASE_PROJECT_CODE", userDetails.getBase_project());
						session.setAttribute("SESSION_ID", obj.getUser_session_id());
						attributes.addFlashAttribute("welcome", "welcome "+userDetails.getUser_name());
						attributes.addFlashAttribute("NewUser", "welcome "+userDetails.getUser_name());
					//}else {
						//session.invalidate();
						//model.addObject("multipleLoginFound","Multiple Login found! You have been Logged out from all Devices");
						//model.setViewName(PageConstants.login); 
					//}
				}else{
					model.addObject("invalidEmail",invalidUserName);
					model.setViewName(PageConstants.newUserLogin);
					List<Plant> projectsList = service4.getPlantsList(null);
					model.addObject("projectsList", projectsList);
					List<User> usersList = service2.getUsersList(null);
					model.addObject("usersList", usersList);
					  List<Department> departmentList= service_dept.getDepartmentsList(null);
			            model.addObject("departmentList", departmentList);
			            
					List<Project> sbuList = service5.getSBUsList(null);
					model.addObject("sbuList", sbuList);
				}
				
			}
			else {
				attributes.addFlashAttribute("error","Adding User is failed. Try again.");
			}
		} catch (Exception e) {
			attributes.addFlashAttribute("error","Adding User is failed. Try again.");
			e.printStackTrace();
		}
		return model;
	}
	
	
	private void prepareFormModel(Model model, String email) throws Exception {
	    model.addAttribute("email", email);

	    List<Plant> projectsList = service4.getPlantsList(null);
	    model.addAttribute("projectsList", projectsList);

	    List<Department> departmentList = service_dept.getDepartmentsList(null);
	    model.addAttribute("departmentList", departmentList);

	    List<Project> sbuList = service5.getSBUsList(null);
	    model.addAttribute("sbuList", sbuList);
	}
	
	
	@RequestMapping(value = "/logout", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView logout(HttpSession session,HttpServletRequest request,HttpServletResponse response,RedirectAttributes attributes){
		ModelAndView model = new ModelAndView();
		User user = new User();
		try {
			user.setUser_id((String) session.getAttribute("USER_ID"));
			user.setId((String) session.getAttribute("ID"));
			session.invalidate();
			//model.addObject("success", logOutMessage);
			model.setViewName("redirect:/login");
		} catch (Exception e) {
			logger.fatal("logut() : "+e.getMessage());
		}
		return model;
	}
	
		
}
