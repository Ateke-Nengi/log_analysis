# Apache Log Analysis Project

**Analyst:** Ateke Tamunonengieofori  
**Date:** 26th June 2026  
**Environment:** Kali Linux  
**Tools:** `grep`, `awk`, `sort`, `uniq`, `wc`

---

## Objective

Analyse three real-world Apache web server log files to extract key metrics, identify traffic patterns, detect anomalies, and flag security indicators using standard Linux command-line tools.

---

## Repository Structure

```
log-analysis/
│
├── README.md                    ← Project overview (this file)
│
├── logs/
│   ├── access-1.log             ← 156-line Apache access log
│   ├── access-2.log             ← 100-line log with malicious traffic
│   └── apache_logs              ← 10,000-line production-scale log
│
└── commands/
    ├── exercise1_commands.sh    ← Commands for access-1.log
    ├── exercise2_commands.sh    ← Commands for apache_logs
    └── exercise3_commands.sh    ← Commands for access-2.log
```

---

## Executive Summary

Three Apache log files were analysed spanning different scales and threat profiles:

| Log File | Lines | Profile |
|----------|-------|---------|
| `access-1.log` | 156 | Mixed normal and scanning traffic |
| `apache_logs` | 10,000 | High-volume production log, heavy crawler activity |
| `access-2.log` | 100 | Heavily malicious — probing, exploits, binary payloads |

Key findings include Shellshock exploit attempts, HTTP tunneling, port scanning, admin panel enumeration, and malformed binary requests.

---

## Exercise 1 — `access-1.log`

| Question | Answer | Notes |
|----------|--------|-------|
| Number of GET requests | 127 | Dominant HTTP method |
| Unique status codes | 6 | 200, 400, 404, 304 and others |
| HTTP tunneling attempts (CONNECT) | 10 | Likely proxy/tunnel probes |
| Entries with raw binary data | 0 | No non-printable characters detected |
| Unique User Agents (excl. empty) | 55 | High diversity of clients |
| Requests made by Firefox | 11 | Multiple versions observed |

See commands → [`commands/exercise1_commands.sh`](commands/exercise1_commands.sh)

---

## Exercise 2 — `apache_logs`

| Question | Answer | Notes |
|----------|--------|-------|
| Total lines | 10,000 | Large dataset |
| Unique IP addresses | 1,753 | Significant source diversity |
| IP with most traffic | `66.249.73.135` (482 requests) | Identified as Googlebot |
| Most visited URL | `/favicon.ico` (807 requests) | Common browser asset request |
| Total 200 OK responses | 9,126 | High success rate |

See commands → [`commands/exercise2_commands.sh`](commands/exercise2_commands.sh)

---

## Exercise 3 — `access-2.log`

| Question | Answer | Notes |
|----------|--------|-------|
| GET requests | 60 | Primary HTTP method |
| Unique IP addresses | 48 | Moderate source diversity |
| 200 OK responses | 19 | Low success rate — many probes failed |
| 400 Bad Request responses | 38 | High error rate indicating active probing |
| IP that "rang at the doorbell" | `186.64.69.141` | Accessed unusual path |
| Googlebot version | `Googlebot/2.1` | Standard crawler |
| Most frequent Firefox version | `Firefox/31.0` (9 occurrences) | Older version common in proxies |
| Most common HTTP method | GET (60 times) | Expected for web traffic |

See commands → [`commands/exercise3_commands.sh`](commands/exercise3_commands.sh)

---

## Security Observations & Recommendations

**Threats Identified:**
- **Shellshock exploit (CVE-2014-6271)** — IP `61.161.130.241` injected bash payloads via User-Agent and Referer headers attempting to download and execute malicious scripts from a remote server
- **Binary/malformed requests** — IP `80.82.70.24` repeatedly sent raw binary data (`\x00`, `\x04\x01`, `\x05\x01`) probing the server
- **HTTP tunneling** — Multiple IPs attempted CONNECT method requests to route traffic through the server as a proxy
- **Automated scanning** — Evidence of `masscan`, `Nmap Scripting Engine`, and `zgrab` scanning tools
- **Admin enumeration** — Repeated probing of `/admin/`, `/manager/html`, `/CFIDE/administrator/`, and `xmlrpc.php`
- **AWS metadata service probing** — Requests targeting internal cloud metadata endpoints

**Recommendations:**
- Implement WAF rules to block common probes and known attack signatures
- Apply rate limiting on sensitive endpoints
- Monitor for unusual User-Agents and HTTP methods
- Deploy Fail2Ban or similar tooling to block repeat offenders

---

## Skills Demonstrated

- Apache Combined Log Format parsing
- Linux CLI data extraction and analysis  
- HTTP status code interpretation
- Identification of real-world attack signatures
- Basic threat hunting from raw log data

---

## About

This project was completed as part of building a cybersecurity portfolio focused on log analysis and threat detection — core competencies for SOC Analyst and Junior Security Analyst roles.

**Prepared by:** Ateke Tamunonengieofori  
**Tools used:** Native Kali Linux tools (`grep`, `awk`, `sort`, `uniq`, `wc`)
