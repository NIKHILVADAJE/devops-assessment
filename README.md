# DevOps Assessment Setup
## How to run Database tasks
1. Start database: `docker compose up -d`
2. Run backup: `bash scripts/backup.sh`
3. Run restore: `bash scripts/restore.sh`
## How to validate Terraform
1. `cd envs/dev/`
2. `terraform init`
3. `terraform validate`

## 📊 Database Query Optimization (Part 5)
To optimize the high-frequency query filtering by `city` and `created_at`, we implemented a **Composite Index**:
```sql
CREATE INDEX idx_hotel_bookings_query ON hotel_bookings (city, created_at, org_id, status, amount);
```
**Why this index?**
* **Equality & Range Filtering:** PostgreSQL utilizes B-Tree index fields left-to-right. Placing `city` (equality match) first and `created_at` (range scan) second ensures immediate row reduction.
* **Covering Index Performance:** By including `org_id`, `status`, and `amount`, the query achieves an **Index Only Scan**, bypassing the main table heap storage entirely for grouping and summation.
