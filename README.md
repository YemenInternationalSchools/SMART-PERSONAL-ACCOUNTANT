# المحاسب الشخصي الذكي — SMART PERSONAL ACCOUNTANT
1. أنشئ مشروعًا في supabase.com (الخطة المجانية).
2. SQL Editor: شغّل `supabase-schema.sql` ثم `supabase-rls-policies.sql`.
3. شغّل `supabase-storage.sql` ثم `seed-users.sql` (ينشئ المستخدمين taha وsara وhuda ويربطهم بالصلاحيات). الدخول باسم المستخدم وكلمة المرور فقط (داخليًا username@spa.local).
4. انسخ `configuration.example.js` إلى `configuration.js` وضع URL وanon key.
5. ارفع كل الملفات (مع مجلد assets) إلى مستودع GitHub، ثم Settings > Pages > Deploy from branch (main / root).
المنفّذ حاليًا: الدخول، الكيانات والشعارات، الحسابات، العمليات، لوحة الأرصدة، RLS. غير منفّذ بعد: الاستيراد، المديونيات، التقارير/PDF، المساعد.
