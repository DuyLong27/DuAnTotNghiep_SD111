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
@Table(name = "can_nang")
public class CanNang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_can_nang")
    private Integer id;

    @Size(min = 3, max = 20, message = "Tên cân nặng phải từ 3 đến 20 ký tự!")
    @Pattern(regexp = "^[a-zA-Z0-9\\s]+$", message = "Tên cân nặng không được chứa ký tự đặc biệt!")
    @Column(name = "ten_can_nang")
    private String ten;
}
