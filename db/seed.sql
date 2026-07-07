INSERT INTO hotel_bookings (id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
SELECT 
    uuid_generate_v4(),
    uuid_generate_v4(),
    'HOTEL_' || (100 + (i % 5)),
    CASE 
        WHEN i % 4 = 0 THEN 'delhi' 
        WHEN i % 4 = 1 THEN 'mumbai' 
        WHEN i % 4 = 2 THEN 'pune' 
        ELSE 'bangalore' 
    END,
    CURRENT_DATE + (i % 7),
    CURRENT_DATE + (i % 7) + 3,
    (2000 + (i * 150))::NUMERIC,
    CASE 
        WHEN i % 3 = 0 THEN 'CONFIRMED' 
        WHEN i % 3 = 1 THEN 'PENDING' 
        ELSE 'CANCELLED' 
    END,
    CURRENT_TIMESTAMP - (i % 45 || ' days')::INTERVAL
FROM generate_series(1, 100) AS i;

INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT 
    id,
    'BOOKING_CREATED',
    jsonb_build_object('triggered_by', 'customer', 'gateway', 'stripe'),
    created_at
FROM hotel_bookings
LIMIT 30;
