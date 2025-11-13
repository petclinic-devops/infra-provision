## 🏗️ Cấu trúc thư mục Terraform – `infra-provision`

Thư mục `infra-provision` chứa toàn bộ mã hạ tầng dưới dạng **Infrastructure as Code (IaC)**, sử dụng **Terraform** để tự động hóa việc tạo tài nguyên (EC2, VPC, Security Group,...) trên AWS.

---

### 📁 Cấu trúc thư mục

| Tên file | Mô tả chức năng |
|-----------|----------------|
| **deploy_infra.sh** | Script shell giúp tự động chạy toàn bộ quá trình `terraform init → plan → apply` mà không cần nhập thủ công. Dùng khi muốn triển khai nhanh toàn bộ hạ tầng chỉ với 1 lệnh. |
| **main.tf** | File chính định nghĩa các tài nguyên AWS (như EC2 instances, VPC, subnet, security group,...). Đây là nơi mô tả hạ tầng sẽ được tạo. |
| **outputs.tf** | Khai báo các giá trị đầu ra sau khi Terraform chạy xong (ví dụ: IP của Jenkins server, IP các node trong cluster K8s). |
| **provider.tf** | Định nghĩa nhà cung cấp dịch vụ cloud — ở đây là **AWS provider**, cùng thông tin cấu hình như region, access key,... |
| **terraform.tfvars** | Lưu các giá trị biến (như instance_type, key_pair, subnet_id,...) được sử dụng trong `variables.tf`. Có thể thay đổi để triển khai ở môi trường khác nhau (dev, prod). |
| **variables.tf** | Khai báo danh sách các biến đầu vào được dùng trong các file `.tf`. Giúp code dễ tái sử dụng và tùy chỉnh linh hoạt. |

---

### ⚙️ Cách chạy thủ công (manual)

Khi không dùng script, bạn có thể chạy lần lượt các lệnh Terraform dưới đây trong terminal (thư mục chứa file `.tf`):

```bash
# 1. Khởi tạo Terraform (tải provider và module)
terraform init

# 2. Xem trước những thay đổi sẽ được áp dụng
terraform plan -var-file="terraform.tfvars"

# 3. Triển khai hạ tầng lên AWS
terraform apply -var-file="terraform.tfvars" -auto-approve

# 4. (Tuỳ chọn) Sau khi hoàn thành, có thể xóa toàn bộ hạ tầng:
terraform destroy -var-file="terraform.tfvars" -auto-approve

🚀 **Cách chạy tự động bằng script `deploy_infra.sh`**

Nếu muốn triển khai nhanh chỉ với một lệnh, bạn có thể dùng script:

```bash
chmod +x deploy_infra.sh
./deploy_infra.sh


**Ưu điểm của cách này:**

- Triển khai nhanh hơn, không cần nhập lệnh từng bước.  
- Giúp đảm bảo tính nhất quán khi nhiều người cùng chạy hạ tầng.

---

### 🧱 Kết quả sau khi chạy

Sau khi `terraform apply` hoàn tất, hệ thống sẽ tự động tạo ra:

- 01 EC2 instance cho Jenkins Server.  
- 03 EC2 instances để tạo thành Kubernetes Cluster (1 Master + 2 Worker).  
- Cấu hình mạng (VPC, Subnet, Security Group, Key Pair) tương ứng.  
- Xuất ra địa chỉ IP của toàn bộ server trong file output.

