package com.example.demo.repository;

import com.example.demo.entity.MucDoRang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MucDoRangRepo extends JpaRepository<MucDoRang, Integer> {
}
