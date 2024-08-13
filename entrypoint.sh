#!/bin/sh

# Function to check if migrations have been applied
check_migrations() {
    echo "Checking for applied migrations..."

    # Check if the migrations table exists and has records
    if python manage.py showmigrations --plan | grep ' [X]' > /dev/null; then
        echo "Migrations have been applied."
        return 0
    else
        echo "No migrations found or not applied."
        return 1
    fi
}

# Function to check if superuser exists
check_superuser() {
    echo "Checking for superuser..."

    # Check if there is at least one superuser in the database
    python manage.py shell -c "from django.contrib.auth.models import User; exit(not User.objects.filter(is_superuser=True).exists())"

    # The exit status is 1 if no superuser exists, 0 otherwise
    if [ $? -eq 0 ]; then
        echo "Superuser exists."
        return 0
    else
        echo "No superuser found."
        return 1
    fi
}

# Apply migrations if not already applied
if ! check_migrations; then
    echo "Applying database migrations..."
    python manage.py migrate --noinput
fi

# Create superuser if not already created
if ! check_superuser; then
    echo "Creating superuser..."
    python manage.py createsuperuser --noinput
else
    echo "Superuser already exists."
fi

# Start Gunicorn
echo "Starting Gunicorn..."
exec gunicorn core.wsgi:application --bind 0.0.0.0:8000
