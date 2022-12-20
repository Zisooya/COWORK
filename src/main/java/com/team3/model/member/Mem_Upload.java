package com.team3.model.member;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.Iterator;

@Service
public class Mem_Upload {
    public String fileUpload(MultipartHttpServletRequest mRequest) {
        String saveFileName = "";

        String homedir = "C:\\dev\\workspace\\workspace(spring)\\COWORK\\src\\main\\webapp\\resources\\mem_upload";

        Iterator<String> iterator = mRequest.getFileNames();
        while(iterator.hasNext()) {
            String uploadFileName = iterator.next();
            MultipartFile mFile = mRequest.getFile(uploadFileName);
            System.out.println("uploadFileName >> " + uploadFileName);
            String originalFileName = mFile.getOriginalFilename();
            System.out.println("originalFileName >> " + originalFileName);

            File path1 = new File(homedir);
            if(!path1.exists()) {
                path1.mkdirs();
            }

            saveFileName = originalFileName;
            if(!saveFileName.equals("")) {
                saveFileName = System.currentTimeMillis() + "_" + saveFileName;

                try {
                    File origin = new File(homedir + "/" + saveFileName);

                    mFile.transferTo(origin);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        System.out.println("savefilename >> " + saveFileName);

        return saveFileName;
    }
}
