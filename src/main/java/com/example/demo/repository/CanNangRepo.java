package com.example.demo.repository;

import com.example.demo.entity.CanNang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CanNangRepo extends JpaRepository<CanNang, Integer> {
}
