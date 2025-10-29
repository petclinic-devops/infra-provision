# Infra-Provision

## Mục tiêu

Dự án này sử dụng Terraform để tự động hóa việc tạo hạ tầng trên AWS, bao gồm:
- 1 máy chủ Jenkins
- 3 máy chủ node cho cluster Kubernetes

## Cấu trúc thư mục

```
infra-provision/
├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
└── README.md
```

## Các thành phần chính

- **main.tf**: Định nghĩa tài nguyên AWS (VPC, subnet, EC2 instances, ...)
- **outputs.tf**: Xuất ra các thông tin quan trọng sau khi khởi tạo (IP, DNS, ...)
- **provider.tf**: Cấu hình provider AWS
- **variables.tf**: Khai báo các biến dùng trong dự án
- **terraform.tf**: Cấu hình backend hoặc các thiết lập Terraform khác

## Hướng dẫn sử dụng

1. **Cài đặt Terraform**  
   Tải và cài đặt Terraform từ [terraform.io](https://www.terraform.io/downloads.html)

2. **Cấu hình AWS credentials**  
   Đảm bảo bạn đã cấu hình AWS CLI hoặc export các biến môi trường `AWS_ACCESS_KEY_ID` và `AWS_SECRET_ACCESS_KEY`.

3. **Khởi tạo Terraform**
   ```sh
   terraform init
   ```

4. **Kiểm tra kế hoạch triển khai**
   ```sh
   terraform plan
   ```

5. **Triển khai hạ tầng**
   ```sh
   terraform apply
   ```

6. **Xóa hạ tầng**
   ```sh
   terraform destroy
   ```

## Tham khảo

- [Tài liệu Terraform](https://developer.hashicorp.com/terraform/docs)
- [Tài liệu AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---
*Liên hệ: [your-email@example.com]*