# PRACTICE CHALLENGE
# NOTE: This example is hard to test in LocalStack without extra networking setup.
# In a real AWS environment:
# 1. Create a real KeyPair (`ssh-keygen -f my-key.pem`).
# 2. Update real_world_example.tf to point to it.
# 3. Apply.
# 4. SSH into the box: `ssh -i my-key.pem ubuntu@<IP>`
# 5. Check the file: `ls /home/ubuntu/app.conf`.
