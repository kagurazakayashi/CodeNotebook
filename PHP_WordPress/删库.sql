select concat('drop table ',table_name,';') from information_schema.TABLES where table_schema='dbname';
drop table tb_commentmeta;
drop table tb_comments;
drop table tb_links;
drop table tb_options;
drop table tb_postmeta;
drop table tb_posts;
drop table tb_term_relationships;
drop table tb_term_taxonomy;
drop table tb_termmeta;
drop table tb_terms;
drop table tb_usermeta;
drop table tb_users;