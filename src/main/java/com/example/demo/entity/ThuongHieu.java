package com.example.demo.entity;

import jakarta.persistence.*;
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
@Entity
@Table(name = "thuong_hieu")
public class ThuongHieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_thuong_hieu")
    private Integer id;

    @Size(min = 3, max = 20, message = "Tên thương hiệu phải từ 3 đến 20 ký tự!")
    @Pattern(regexp = "^[a-zA-Z0-9\\s]+$", message = "Tên thương hiệu không được chứa ký tự đặc biệt!")
    @Column(name = "ten_thuong_hieu")
    private String ten;
}
