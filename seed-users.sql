-- شغّله مرة واحدة بعد ملفي schema وrls. أسماء الدخول: taha / sara / huda. غيّر كلمات المرور بعد أول تجربة.
create or replace function pg_temp.mk(u text, pw text, nm text, adm boolean, ent text, rl text) returns void language plpgsql as $$
declare uid uuid:=gen_random_uuid(); em text:=u||'@spa.local'; begin
 insert into auth.users(instance_id,id,aud,role,email,encrypted_password,email_confirmed_at,raw_app_meta_data,raw_user_meta_data,created_at,updated_at,confirmation_token,email_change,email_change_token_new,recovery_token)
 values('00000000-0000-0000-0000-000000000000',uid,'authenticated','authenticated',em,crypt(pw,gen_salt('bf')),now(),'{"provider":"email","providers":["email"]}','{}',now(),now(),'','','','');
 insert into auth.identities(id,user_id,provider_id,identity_data,provider,last_sign_in_at,created_at,updated_at)
 values(gen_random_uuid(),uid,uid::text,jsonb_build_object('sub',uid::text,'email',em),'email',now(),now(),now());
 insert into profiles(id,full_name,is_super_admin) values(uid,nm,adm);
 if ent is not null then insert into user_entities select uid,id,rl,true from entities where slug=ent; end if; end $$;
select pg_temp.mk('taha','xAh1pAj2KOA1','د. طه حسين قاضي',true,null,null);
select pg_temp.mk('sara','DsB4eHT4hEB2','سارة الحكيمي',false,'home','HOME_MANAGER');
select pg_temp.mk('huda','FdWgAhsWNGC3','هدى القرش',false,'fahm','FAHM_MANAGER');
