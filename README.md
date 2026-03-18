<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_light.svg">
  <img alt="Hyperglance logo" src="https://raw.githubusercontent.com/hyperglance/deploy/master/files/hyperglance_logo_dark.svg">
</picture>

![AWS](https://img.shields.io/badge/AWS-supported-FF9900?logo=amazonaws&logoColor=white&style=for-the-badge)
![Azure](https://img.shields.io/badge/Azure-supported-0078D4?logo=microsoftazure&logoColor=white&style=for-the-badge)
![GCP](https://img.shields.io/badge/GCP-supported-34A853?logo=googlecloud&logoColor=white&style=for-the-badge)
![Kubernetes](https://img.shields.io/badge/Kubernetes-supported-326CE5?logo=kubernetes&logoColor=white&style=for-the-badge)

> Hyperglance is the cloud management platform of choice for engineers, architects, security, DevOps and FinOps teams worldwide. Trusted by industry leaders in the private & public sectors, including prominent government agencies, Hyperglance's super-secure deployment combines powerful **cost optimization**, enlightening visualizations, **security & compliance monitoring**, and customizable **automated remediation**.

# Get Started With Hyperglance

## Table of Contents

- [Key Features](#key-features)
- [Quick Reference](#quick-reference)
- [Deployment Options](#deployment-options)
  - [Deploy to AWS](#deploy-to-aws)
  - [Deploy to Azure](#deploy-to-azure)
  - [Deploy to GCP](#deploy-to-gcp)
  - [Deploy to Kubernetes](#deploy-to-kubernetes)
  - [Install on your own VM](#install-on-your-own-vm)
- [Getting Help](#getting-help)

## Key Features

- 💰 **Cost Optimization & FinOps** — Identify and eliminate cloud waste across accounts
- 🔒 **Security & Compliance monitoring** — Continuous posture assessment against industry frameworks
- 📊 **Cloud Visualization** — Interactive diagrams of your entire multi-cloud estate
- 🤖 **Automated Remediation** — Customizable rules that fix issues without manual intervention


## Quick Reference

Hyperglance runs self-hosted in your enivironment.  Follow one of the guides to get started!

| Platform | Method | Launch Template | Role Template | Guide |
|----------|--------|-----------------|---------------|-------|
| AWS | CloudFormation | [EC2](AWS/CloudFormation/EC2) | [XAccount Role](AWS/CloudFormation/XAccount) | [AWS guide](https://support.hyperglance.com/knowledge/deployment-guide-for-aws) |
| AWS | Terraform | [EC2](AWS/Terraform/EC2) | [XAccount Role](AWS/Terraform/XAccount) | [AWS guide](https://support.hyperglance.com/knowledge/deployment-guide-for-aws) |
| Azure | ARM / Bicep | [VM](Azure/ARM/VM) | [Role](Azure/ARM/Role) | [Azure guide](https://support.hyperglance.com/knowledge/deployment-guide-for-azure) |
| GCP | Marketplace | — | — | [GCP guide](https://support.hyperglance.com/knowledge/how-to-set-up-hyperglance-via-the-gcp-marketplace) |
| Kubernetes | Helm | — | — | [Helm chart repo](https://github.com/hyperglance/helm-chart) |
| Linux | Installer (ansible) | — | — | [Install guide](https://support.hyperglance.com/knowledge/installing-hyperglance-on-your-own-instance-or-vm) |

## Deployment Options

### Deploy to AWS

[Follow our AWS deployment guide](https://support.hyperglance.com/knowledge/deployment-guide-for-aws) to launch Hyperglance as an EC2 Instance.

This repository hosts [CloudFormation](AWS/CloudFormation/EC2) and [Terraform](AWS/Terraform/EC2) deployment templates to launch a Hyperglance EC2 Instance.

For cross-account role setup, see [CloudFormation XAccount](AWS/CloudFormation/XAccount) or [Terraform XAccount](AWS/Terraform/XAccount).

---

### Deploy to Azure

[Follow our Azure deployment guide](https://support.hyperglance.com/knowledge/deployment-guide-for-azure) to launch Hyperglance as a VM.

This repository hosts [ARM and Bicep](Azure/ARM/VM) deployment templates to launch a Hyperglance VM, and a [Role template](Azure/ARM/Role) for access configuration.

---

### Deploy to GCP

[Follow our GCP deployment guide](https://support.hyperglance.com/knowledge/how-to-set-up-hyperglance-via-the-gcp-marketplace) to launch Hyperglance as a VM through the GCP Marketplace.

---

### Deploy to Kubernetes

Deploy Hyperglance to your Kubernetes cluster with [our Helm Chart](https://github.com/hyperglance/helm-chart).

---

### Install on your own VM

If you need to install Hyperglance on your own hardened/golden Linux VM, [follow these instructions](https://support.hyperglance.com/knowledge/installing-hyperglance-on-your-own-instance-or-vm). The Hyperglance installer uses Ansible and Docker to install Hyperglance on supported Linux distributions.



## Getting Help

| Resource | Link |
|----------|------|
| 📖 Deployment guide | [Launch Guide](https://support.hyperglance.com/knowledge/launch-guide) |
| 🧑‍💻 Assisted install with an engineer | [Book a session](https://www.hyperglance.com/get-started/) |
| 🎯 Live demo | [Book a demo](https://www.hyperglance.com/get-demo/) |
| 🛟 Support portal | [support.hyperglance.com](https://support.hyperglance.com) |
| 🔐 Security policy | [SECURITY.md](SECURITY.md) |
