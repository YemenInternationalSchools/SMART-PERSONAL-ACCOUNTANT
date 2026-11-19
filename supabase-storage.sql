insert into storage.buckets(id,name,public) values('docs','docs',false) on conflict do nothing;
create policy docs_sel on storage.objects for select to authenticated using (bucket_id='docs' and can_see(((storage.foldername(name))[1])::uuid));
create policy docs_ins on storage.objects for insert to authenticated with check (bucket_id='docs' and can_edit(((storage.foldername(name))[1])::uuid));
