package com.example.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private RoleInterceptor roleInterceptor;
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Đường dẫn tuyệt đối tới thư mục uploads
        String uploadsPath = Paths.get("src/main/webapp/uploads/").toAbsolutePath().toString();
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + uploadsPath + "/");

        // Đường dẫn tuyệt đối tới thư mục images
        String imagesPath = Paths.get("src/main/webapp/images/").toAbsolutePath().toString();
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:" + imagesPath + "/");


        // Đường dẫn tuyệt đối tới thư mục lib
        String libPath = Paths.get("src/main/webapp/lib/").toAbsolutePath().toString();
        registry.addResourceHandler("/lib/**")
                .addResourceLocations("file:" + libPath + "/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(roleInterceptor)
                .addPathPatterns(
                        "/bao-cao/**",
                        "/doanh-thu/**",
                        "/hoa-don/**",
                        "/quan-ly-khach-hang/**",
                        "/kho-hang/**",
                        "/quan-ly-khuyen-mai/**",
                        "/lich-su/**",
                        "/nha-cung-cap/**",
                        "/nhan-vien/**",
                        "/nhap-hang/**",
                        "/spct/**",
                        "/san-pham/**",
                        "/thuoc-tinh/**",
                        "/qrcode/**"
                );
    }
}
