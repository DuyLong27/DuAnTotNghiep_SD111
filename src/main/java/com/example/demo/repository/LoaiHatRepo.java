package com.example.demo.repository;

import com.example.demo.entity.LoaiHat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoaiHatRepo extends JpaRepository<LoaiHat, Integer> {
}
