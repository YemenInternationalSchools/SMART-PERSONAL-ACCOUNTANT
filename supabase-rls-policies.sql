create function is_admin() returns boolean language sql stable security definer as $$ select coalesce((select is_super_admin from profiles where id=auth.uid()),false) $$;
create function can_see(e uuid) returns boolean language sql stable security definer as $$ select is_admin() or exists(select 1 from user_entities where user_id=auth.uid() and entity_id=e) $$;
create function can_edit(e uuid) returns boolean language sql stable security definer as $$ select is_admin() or exists(select 1 from user_entities where user_id=auth.uid() and entity_id=e and can_write) $$;
do $$ declare t text; begin
 foreach t in array array['accounts','transactions','journal_entries','attachments'] loop
  execute format('alter table %I enable row level security',t);
  execute format('create policy "%1$s_sel" on %1$I for select using (can_see(entity_id))',t);
  execute format('create policy "%1$s_ins" on %1$I for insert with check (can_edit(entity_id))',t);
  execute format('create policy "%1$s_upd" on %1$I for update using (can_edit(entity_id))',t);
 end loop; end $$;
alter table entities enable row level security; create policy ent_sel on entities for select using (can_see(id)); create policy ent_upd on entities for update using (is_admin());
alter table profiles enable row level security; create policy pr_sel on profiles for select using (id=auth.uid() or is_admin());
alter table user_entities enable row level security; create policy ue_sel on user_entities for select using (user_id=auth.uid() or is_admin()); create policy ue_all on user_entities for all using (is_admin());
alter table journal_lines enable row level security; create policy jl_sel on journal_lines for select using (exists(select 1 from journal_entries j where j.id=entry_id and can_see(j.entity_id)));
create policy jl_ins on journal_lines for insert with check (exists(select 1 from journal_entries j where j.id=entry_id and can_edit(j.entity_id) and not j.posted));
alter table audit_logs enable row level security; create policy al_sel on audit_logs for select using (is_admin());
-- لا توجد سياسة delete: الحذف ممنوع. المرفقات: أنشئ bucket خاصًا باسم docs وسياسة تخزين تعتمد على أول مجلد = entity_id.
