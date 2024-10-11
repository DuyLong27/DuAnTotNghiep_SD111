package com.example.demo.repository;

import com.example.demo.entity.HuongVi;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HuongViRepo extends JpaRepository<HuongVi, Integer> {
}
