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
@Table(name = "loai_ca_phe")
public class LoaiCaPhe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_loai_ca_phe")
    private Integer id;

    @Size(min = 3, max = 20, message = "Tên loại cà phê phải từ 3 đến 20 ký tự!")
    @Pattern(regexp = "^[a-zA-Z0-9\\s]+$", message = "Tên loại cà phê không được chứa ký tự đặc biệt!")
    @Column(name = "ten_loai_ca_phe")
    private String ten;
}
