#!/bin/bash
# ============================================================
# Exercise 2 — Analysis of apache_logs
# Analyst: Ateke Tamunonengieofori
# Environment: Kali Linux
# ============================================================

# Q1: How many lines are there in the log file in total?
wc -l apache_logs
# Answer: 10,000

# Q2: How many unique IP addresses are there?
awk '{print $1}' apache_logs | sort -u | wc -l
# Answer: 1,753

# Q3: What IP address sent the most traffic?
awk '{print $1}' apache_logs | sort | uniq -c | sort -nr | head -1
# Answer: 66.249.73.135 (482 requests) — Googlebot crawler

# Q4: What URL was most visited?
awk -F'"' '{print $2}' apache_logs | awk '{print $2}' 2>/dev/null | sort | uniq -c | sort -nr | head -1
# Answer: /favicon.ico (807 requests)

# Q5: What is the total count of requests that returned a 200 response?
grep -c '200' apache_logs
# Answer: 9,126
