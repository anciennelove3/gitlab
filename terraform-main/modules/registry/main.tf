resource "yandex_container_registry" "this" {
  name   = "${var.name_prefix}-cr"
  labels = var.labels
}

# Репозиторий для образов приложения
resource "yandex_container_repository" "app" {
  # Имя должно начинаться с ID реестра
  name = "${yandex_container_registry.this.id}/app"
}

# Политика удаления старых образов в репозитории
resource "yandex_container_repository_lifecycle_policy" "cleanup" {
  name          = "${var.name_prefix}-cleanup"
  repository_id = yandex_container_repository.app.id
  status        = "active" # или "disabled"

  rule {
    description   = "delete older than 14d"
    tag_regexp    = ".*"
    untagged      = false
    expire_period = "336h" # 14 дней
  }
}

