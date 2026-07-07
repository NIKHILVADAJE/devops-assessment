DO $$
BEGIN
  FOR i IN 1..100 LOOP
    INSERT INTO hotel_bookings (id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
    VALUES (
      gen_random_uuid(),
      gen_random_uuid(),
      'HOTEL-' || (100 + i),
      CASE WHEN i % 3 = 0 THEN 'delhi' WHEN i % 3 = 1 THEN 'mumbai' ELSE 'bangalore' END,
      CURRENT_DATE + (i % 5),
      CURRENT_DATE + (i % 5) + 3,
      (1500.00 + (i * 50)),
      CASE WHEN i % 4 = 0 THEN 'CONFIRMED' WHEN i % 4 = 1 THEN 'PENDING' ELSE 'CANCELLED' END,
      NOW() - (i || ' days')::INTERVAL
    );
  END LOOP;
END $$;
