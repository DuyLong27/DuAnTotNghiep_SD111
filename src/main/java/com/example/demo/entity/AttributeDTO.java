package com.example.demo.entity;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AttributeDTO {
    @Size(min = 3, max = 20, message = "Tên thuộc tính phải từ 3 đến 20 ký tự!")
    @Pattern(regexp = "^[a-zA-Z0-9\\sÀ-ỹà-ỹ]+$", message = "Tên thuộc tính không được chứa ký tự đặc biệt!")
    private String propertyName;
}
