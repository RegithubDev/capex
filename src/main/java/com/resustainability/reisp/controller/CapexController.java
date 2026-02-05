package com.resustainability.reisp.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.service.CapexService;

@Controller
@RequestMapping("/form")
public class CapexController {

    @Autowired
    private CapexService capexService;

    @RequestMapping(value = "/submit", method = {RequestMethod.POST, RequestMethod.GET})
    public String submitCapex(
            HttpServletRequest request,
            @RequestParam(value = "roiFile", required = false) MultipartFile roiFile,
            @RequestParam(value ="timelineFile", required = false) MultipartFile timelineFile,
            @RequestParam(value ="reasonFile", required = false) MultipartFile reasonFile,
            @RequestParam(value ="preparedBySignature", required = false) MultipartFile preparedBySignature,
            RedirectAttributes redirectAttributes
    ) {
        try {
            capexService.submitCapex(request, roiFile, timelineFile, reasonFile, preparedBySignature);
            redirectAttributes.addFlashAttribute("success", "CAPEX submitted successfully");
            return "redirect:/home";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error while submitting CAPEX");
            return "redirect:/home";
        }
    }
}
