#!/bin/bash
# ============================================
# 🚀 Script tự động triển khai hạ tầng AWS bằng Terraform (Linux)
# ============================================

set -e
set -o pipefail

# === 1️⃣ CÀI ĐẶT CÔNG CỤ (NẾU CHƯA CÓ) ===
echo "🔧 Kiểm tra công cụ cần thiết..."

# Terraform
if ! command -v terraform &>/dev/null; then
  echo "📦 Cài đặt Terraform..."
  sudo apt-get update -y
  sudo apt-get install -y gnupg software-properties-common curl unzip
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt-get update && sudo apt-get install -y terraform
else
  echo "✅ Terraform đã được cài đặt."
fi

# AWS CLI v2
if ! command -v aws &>/dev/null; then
  echo "📦 Cài đặt AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf awscliv2.zip aws
else
  echo "✅ AWS CLI đã được cài đặt."
fi

# === 2️⃣ CẤU HÌNH AWS CREDENTIALS ===
echo "🔐 Kiểm tra AWS credentials..."

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "❌ Chưa có AWS credentials trong môi trường."
  read -p "AWS Access Key ID: " AWS_ACCESS_KEY_ID
  read -p "AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
  read -p "AWS Region (ví dụ: ap-southeast-1): " AWS_REGION

  mkdir -p ~/.aws
  cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

  cat > ~/.aws/config <<EOF
[default]
region = $AWS_REGION
output = json
EOF

  echo "✅ AWS credentials đã được cấu hình tại ~/.aws/"
else
  echo "✅ AWS credentials phát hiện từ biến môi trường."
fi

# === 3️⃣ KHỞI TẠO TERRAFORM ===
echo "🚀 Khởi tạo Terraform..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

terraform init -input=false

# === 4️⃣ KIỂM TRA CẤU HÌNH ===
echo "🧩 Kiểm tra cú pháp Terraform..."
terraform validate
echo "📋 Tạo kế hoạch triển khai..."
terraform plan -out=tfplan -input=false

# === 5️⃣ TRIỂN KHAI HẠ TẦNG ===
echo "💥 Triển khai hạ tầng..."
terraform apply -auto-approve tfplan

# === 6️⃣ HIỂN THỊ KẾT QUẢ ===
echo "✅ Hạ tầng triển khai thành công!"
terraform output

echo "🎉 Hoàn tất!"