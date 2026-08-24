# 🛡️ Spamhaus DROP - Blocklist Unificada

## 📊 Estatísticas Atuais

| Métrica | Valor |
|---------|-------|
| **Última atualização** | ![Last Update](https://img.shields.io/github/last-commit/marciosx/spamhaus_drop) |
| **IPs únicos** | ![IPs](https://img.shields.io/badge/dynamic/json?color=orange&label=IPs&query=ips_unicos&url=https%3A%2F%2Fraw.githubusercontent.com%2Fmarciosx%2Fspamhaus_drop%2Fmain%2Fstats.json) |
| **Sub-redes /24 agregadas** | ![Subnets](https://img.shields.io/badge/dynamic/json?color=purple&label=Subnets&query=subredes&url=https%3A%2F%2Fraw.githubusercontent.com%2Fmarciosx%2Fspamhaus_drop%2Fmain%2Fstats.json) |
| **Tamanho** | ![Size](https://img.shields.io/badge/dynamic/json?color=blue&label=Size&query=tamanho_kb&url=https%3A%2F%2Fraw.githubusercontent.com%2Fmarciosx%2Fspamhaus_drop%2Fmain%2Fstats.json&suffix=KB) | |


## 📋 Descrição

Lista unificada de IPs maliciosos e blocos CIDR, atualizada automaticamente a partir de **24 fontes** de threat intelligence.



## 📦 Lista Completa de Fontes (24)

### 🔵 OTX AlienVault (5 listas)

| # | Nome | ID do Pulse |
|---|------|-------------|
| 1 | HoneyAI_HTTP_Honeypot | `69ebf361c06a57718d0c0838` |
| 2 | PurpleSynapz | `5de8ad9a8b95247cfa55def7` |
| 3 | HoneyAI_Network_Services_Attack_Feed | `6a3407d69c9a31c90e0debe2` |
| 4 | Federal_Agencies_Warn | `6a6ab0b45dd9e2b4b1972bca` |
| 5 | DatasoftComnet-AntiSpam | `62ed397d23b4894198f2816e` |

### 🟢 Listas Tradicionais (19)

#### Spamhaus & Emerging Threats

| # | Nome | Descrição |
|---|------|-----------|
| 6 | Spamhaus DROP | Blocos CIDR de redes maliciosas |
| 7 | Emerging Threats | IPs comprometidos |

#### Abuse.ch & Blocklist.de

| # | Nome | Descrição |
|---|------|-----------|
| 8 | Feodo Tracker | IPs de C&C e botnets |
| 9 | blocklist.de (all) | Lista completa de atacantes |
| 10 | blocklist.de (bruteforce) | IPs com tentativas de força bruta |

#### Score & Intelligence

| # | Nome | Descrição |
|---|------|-----------|
| 11 | CINS Score | IPs com pontuação de risco |
| 12 | public-xlogic | IPs maliciosos |

#### DShield & Defense

| # | Nome | Descrição |
|---|------|-----------|
| 13 | DShield | IPs reportados ao DShield |
| 14 | Binary Defense | Lista de banimento |

#### OpenDBL (5 listas)

| # | Nome | Descrição |
|---|------|-----------|
| 15 | OpenDBL - blocklistde-all | Lista completa |
| 16 | OpenDBL - bruteforce | Tentativas de força bruta |
| 17 | OpenDBL - tor-exit | Nós de saída Tor |
| 18 | OpenDBL - etknown | IPs conhecidos |
| 19 | OpenDBL - ipsum | IPs maliciosos |

#### Threat Intel & Locais

| # | Nome | Descrição |
|---|------|-----------|
| 20 | Ziyadnz Threat Intel | Feed de inteligência |
| 21 | Netlas | Lista local |
| 22 | Saints List | Lista local |

#### Governo & Abuse

| # | Nome | Descrição |
|---|------|-----------|
| 23 | SERPRO Blocklist | Lista do SERPRO |
| 24 | ThreatFox (abuse.ch) | IPs da ThreatFox |

### Categorias de Origem

Os IPs e CIDRs são marcados com a origem no arquivo:

- `OTX_*`: Fontes do AlienVault OTX
- `spamhaus-drop`: Spamhaus DROP
- `emergingthreats`: Emerging Threats
- `blocklist.de`: blocklist.de
- `cins`: CINS Score
- `dshield`: DShield
- `opendbl-*`: OpenDBL
- `threatfox`: ThreatFox (abuse.ch)
- `bruteforceblocker`: BruteforceBlocker
- `serpro`: SERPRO Blocklist
- `netlas`: Netlas
- `saints`: Saints List
- `ziyadnz`: Ziyadnz Threat Intel

## 🚀 Como Usar

**Em firewalls (Fortigate/pfSense/OPNsense)**

```
URL: https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt
```

**Em MikroTik RouterOS**

```
/tool fetch url="https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt" dst-path=blocklist.txt
/import file=blocklist.txt
```

**Em iptables**

```bash
curl -s https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt | \
    grep -E '^[0-9]' | \
    while read ip; do
        iptables -A INPUT -s $ip -j DROP
    done
```

**Em Python**

```python
import requests

url = "https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt"
response = requests.get(url)
ips = [line.split('#')[0].strip() for line in response.text.splitlines()
       if line and not line.startswith('#')]
```

**Em PowerShell**

```powershell
$url = "https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt"
$ips = Invoke-WebRequest -Uri $url |
    Select-Object -ExpandProperty Content |
    Where-Object { $_ -notmatch '^#' -and $_ -match '^[0-9]' }
```

### 🔄 Frequência de Atualização

Automática: a cada hora via CRON.

### 📝 Formato do Arquivo

```
<IP ou CIDR> # <origem> [informações adicionais]

192.168.1.1 # spamhaus-drop
10.0.0.0/24 # OTX_HoneyAI_HTTP_Honeypot
172.16.0.0/24 # subnet-agregado(20_IPs) otx,spamhaus,emerging
```

### 🔧 Como os Dados São Coletados

Os dados são gerados automaticamente por um script PowerShell que unifica todas as 24 fontes.

**Script:** Blocklist Unifier

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://microsoft.com/powershell)
[![Version](https://img.shields.io/badge/version-3.2-green.svg)](CHANGELOG.md)


### ✨ Características do Script

- 🔒 24 fontes de threat intelligence ativas
- 🚀 Coleta paralela com timeout e retry automático
- 🧹 Deduplicação inteligente com agregação de sub-redes /24
- 📊 Logs rotativos (manhã/tarde) com retenção de 1 dia
- 🛡️ Suporte OTX AlienVault via API oficial (com paginação)
- 📝 Histórico dos últimos 3 dias

### ⚠️ Aviso

Esta lista é fornecida "como está", sem garantias de qualquer tipo. Recomenda-se:

- ✅ Testar antes de usar em produção
- ✅ Manter backups regulares
- ✅ Verificar periodicamente a precisão dos dados
- ✅ Monitorar falsos positivos
- ✅ Ter um plano de contingência

O uso desta lista é de inteira responsabilidade do usuário.

### 📜 Licença

Este conjunto de dados é fornecido sob a licença MIT. As fontes originais podem ter suas próprias licenças.

MIT License - Copyright (c) 2026 marciosx

## 📧 Contato

- Issues: GitHub Issues
- Email: marciosx@gmail.com

## 🎯 Download



### Arquivo completo
```bash
# Baixar a allowlist
wget https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/allowlist.txt

# Última versão
wget https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt

# Ou via curl
curl -O https://raw.githubusercontent.com/marciosx/spamhaus_drop/main/spamhaus_drop.txt

```
