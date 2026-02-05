package com.resustainability.reisp.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public interface CapexService {
    void submitCapex(HttpServletRequest request,
                     MultipartFile roiFile,
                     MultipartFile timelineFile,
                     MultipartFile reasonFile,
                     MultipartFile preparedBySignature) throws Exception;
}
