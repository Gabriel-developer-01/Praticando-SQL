
/* PRATICANDO SQL */

/*1. quais os países cadastrados?*/
select * from pais;

/*2. quantos países estão cadastrados?*/
select count(*) from pais;

/*3. quantos países que terminam com a letra "a" estão cadastrados?*/
select count(*) from pais where pais like "%a";

/*4. listar, sem repetição, os anos que houveram lancamento de filme.*/
select distinct(ano_de_lancamento) from filme;

/*5. alterar o ano de lancamento igual 2007 para filmes que iniciem com a letra "b".*/
update filme set ano_de_lancamento = 2007 where titulo like "b%";

/*6. listar os filmes que possuem duracao do filme maior que 100 e classificacao igual a "g". */
select * from filme where duracao_do_filme > 100 and classificacao = 'g';

/*7. alterar o ano de lancamento igual 2008 para filmes que possuem duracao da locacao menor que 4 e classificacao igual a "pg". */
update filme set ano_de_lancamento = 2008 where duracao_da_locacao < 4 and classificacao = 'pg';

/*8. listar a quantidade de filmes que estejam classificados como "pg-13" e preco da locacao maior que 2.40.*/
select count(*) from filme where preco_da_locacao > 2.40 and classificacao = "pg-13";

/*9. quais os idiomas que possuem filmes cadastrados? */
select distinct(nome) from filme f, idioma i where f.idioma_id = i.idioma_id;

/*10. alterar o idioma para "german" dos filmes que possuem preco da locacao maior que 4.*/
update filme set idioma_id = 6 where preco_da_locacao > 4;

/*11. alterar o idioma para "japanese" dos filmes que possuem preco da locacao igual 0.99.*/
update filme set idioma_id = (select idioma_id from idioma where nome = "japanese") where preco_da_locacao = 0.99;

/*12. listar a quantidade de filmes por classificacao.*/
select classificacao, count(*) from filme group by classificacao;

/*13. listar, sem repetição, os precos de locacao dos filmes cadastrados.*/
select distinct(preco_da_locacao) from filme;

/*14. listar a quantidade de filmes por preco da locacao.*/
select preco_da_locacao, count(*) from filme group by preco_da_locacao;

/*15. lsitar os precos da locacao que possuam mais de 340 filmes.*/
select preco_da_locacao, count(*) from filme group by preco_da_locacao having count(*) > 340;

/*16. listar a quantidade de atores por filme ordenando por quantidade de atores crescente.*/
select titulo, count(ator_id) from filme f, filme_ator fa where f.filme_id = fa.filme_id 
group by titulo order by 2 asc;

/*17. listar a quantidade de atores para os filmes que possuem mais de 5 atores ordenando por quantidade de atores decrescente.*/
select titulo, count(ator_id) from filme f, filme_ator fa where f.filme_id = fa.filme_id 
group by titulo having count(ator_id) > 5 order by 2 desc;

/*18. listar o titulo e a quantidade de atores para os filmes que possuem o idioma "english" 
e mais de 10 atores ordenando por ordem alfabetica de titulo e ordem crescente de quantidade de atores.*/
select titulo, count(ator_id) from filme f, filme_ator fa where f.filme_id = fa.filme_id and idioma_id = 1 
group by titulo having count(ator_id) >= 10 order by 1, 2;

/*19. qual a maior duração da locação dentre os filmes?*/
select max(duracao_da_locacao) from filme;

/*20. quantos filmes possuem a maior duração de locação?*/
select count(*) from filme where duracao_da_locacao = (select max(duracao_da_locacao) from filme);

/*21. quantos filmes do idioma "japanese" ou "german" possuem a maior duração de locação?*/
select count(*) from filme where duracao_da_locacao = 
(select max(duracao_da_locacao) from filme) and (idioma_id = 3 or idioma_id = 6);

/*22. qual a quantidade de filmes por classificação e preço da locação?*/
select classificacao, preco_da_locacao, count(*) from filme group by classificacao, preco_da_locacao;

/*23. qual o maior tempo de duração de filme por categoria?*/
select nome, max(duracao_do_filme) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id  group by 1;

/*24. listar a quantidade de filmes por categoria.*/
select nome, count(*) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id group by nome;

/*25. listar a quantidade de filmes classificados como "g" por categoria.*/
select nome, count(*) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id and classificacao = "g" group by nome;

/*26. listar a quantidade de filmes classificados como "g" ou "pg" por categoria.*/
select nome, count(*) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id and (classificacao = "g" or classificacao = 'pg') group by nome;

/*27. listar a quantidade de filmes por categoria e classificação.*/
select c.nome, classificacao, count(*) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id group by nome, classificacao;

/*28. qual a quantidade de filmes por ator ordenando decrescente por quantidade?*/
select primeiro_nome, count(titulo) from filme f, filme_ator fa, ator a where f.filme_id = fa.filme_id and fa.ator_id = a.ator_id 
group by primeiro_nome order by 2 desc;

/*29. qual a quantidade de filmes por ano de lançamento ordenando por quantidade crescente?*/
select ano_de_lancamento, count(titulo) from filme group by ano_de_lancamento order by 1;

/*30. listar os anos de lançamento que possuem mais de 400 filmes?*/
select ano_de_lancamento from filme group by ano_de_lancamento having count(titulo) > 400;

/*31. listar os anos de lançamento dos filmes que possuem mais de 100 filmes com preço da locação maior que a média do preco da locação dos filmes da categoria "children"?*/
select ano_de_lancamento from filme where preco_da_locacao > 
(select avg(preco_da_locacao) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id and nome = 'children')
group by ano_de_lancamento having count(titulo) > 100;

/*32. quais as cidades e seu pais correspondente que pertencem a um país que inicie com a letra “e”?*/
select cidade, pais from cidade c, pais p where c.pais_id = p.pais_id and pais like 'e%';

/*31. qual a quantidade de cidades por pais em ordem decrescente?*/
select pais, count(*) from cidade c, pais p where c.pais_id = p.pais_id group by pais order by 2 desc;

/*32. qual a quantidade de cidades que iniciam com a letra “a” por pais em ordem crescente?*/
select pais, count(*) from cidade c, pais p where c.pais_id = p.pais_id and cidade like 'a%' group by pais order by 2 asc;

/*33. quais os paises que possuem mais de 3 cidades que iniciam com a letra “a”?*/
select pais, count(*) from cidade c, pais p where c.pais_id = p.pais_id and cidade like 'a%' group by pais having count(*) > 3;

/*34. quais os paises que possuem mais de 3 cidades que iniciam com a letra “a” ou tenha "r" ordenando por quantidade crescente?*/
select pais, count(*) from cidade c, pais p where c.pais_id = p.pais_id and (cidade like 'a%' or cidade like '%r%') group by pais having count(*) > 3 order by 2 asc;

/*35. quais os clientes moram no país “united states”?*/
select primeiro_nome from cliente c, endereco e, cidade cid, pais p 
where c.endereco_id = e.endereco_id and e.cidade_id = cid.cidade_id and cid.pais_id = p.pais_id and pais = 'united states';

/*36. quantos clientes moram no país “brazil”?*/
select count(*) from cliente c, endereco e, cidade cid, pais p 
where c.endereco_id = e.endereco_id and e.cidade_id = cid.cidade_id and cid.pais_id = p.pais_id and pais = 'brazil';

/*37. qual a quantidade de clientes por pais?*/
select pais, count(*) from cliente c, endereco e, cidade cid, pais p 
where c.endereco_id = e.endereco_id and e.cidade_id = cid.cidade_id and cid.pais_id = p.pais_id group by pais;

/*38. quais paises possuem mais de 10 clientes?*/
select pais, count(*) from cliente c, endereco e, cidade cid, pais p 
where c.endereco_id = e.endereco_id and e.cidade_id = cid.cidade_id and cid.pais_id = p.pais_id group by pais having count(*) > 10;

/*39. qual a média de duração dos filmes por idioma?*/
select nome, avg(duracao_do_filme) from filme f, idioma i where f.idioma_id = i.idioma_id group by 1;

/*40. qual a quantidade de atores que atuaram nos filmes do idioma “english”?*/
select nome, count(ator_id) from filme f, filme_ator fa, idioma i where f.filme_id = fa.filme_id and f.idioma_id = i.idioma_id 
and nome = 'english' group by nome;

/*41. quais os atores do filme “blanket beverly”?*/
select primeiro_nome, ultimo_nome from filme f, filme_ator fa, ator a where f.filme_id = fa.filme_id and fa.ator_id = a.ator_id 
and titulo = 'blanket beverly';

/*42. quais categorias possuem mais de 60 filmes cadastrados?*/
select nome, count(*) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id group by nome having count(*) > 60;

/*43. quais os filmes alugados (sem repetição) para clientes que moram na “argentina”?*/
select distinct(titulo) from cliente c, endereco e, cidade cid, pais p, aluguel a, inventario i, filme f
where c.endereco_id = e.endereco_id and e.cidade_id = cid.cidade_id and cid.pais_id = p.pais_id 
and a.cliente_id = c.cliente_id and i.inventario_id = a.inventario_id and f.filme_id = i.filme_id and pais ='argentina';

/*44. qual a quantidade de filmes alugados por clientes que moram na “chile”?*/
select c.primeiro_nome, count(f.filme_id) from cliente c, endereco e, cidade cid, pais p, aluguel a, inventario i, filme f
where c.endereco_id = e.endereco_id and e.cidade_id = cid.cidade_id and cid.pais_id = p.pais_id 
and a.cliente_id = c.cliente_id and i.inventario_id = a.inventario_id and f.filme_id = i.filme_id and pais ='chile' group by 1;

/*45. qual a quantidade de filmes alugados por funcionario?*/
select f.primeiro_nome, count(*) from funcionario f, aluguel a where f.funcionario_id = a.funcionario_id group by 1;

/*46. qual a quantidade de filmes alugados por funcionario para cada categoria?*/
select fun.primeiro_nome, nome, count(*) from funcionario fun, aluguel a, inventario i, filme f, filme_categoria fc, categoria c 
where fun.funcionario_id = a.funcionario_id and a.inventario_id = i.inventario_id and i.filme_id = f.filme_id 
and f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id group by 1, 2;

/*47. quais filmes possuem preço da locação maior que a média de preço da locação?*/
select titulo from filme where preco_da_locacao > 
(select avg(preco_da_locacao) from filme);

/*48. qual a soma da duração dos filmes por categoria?*/
select nome, sum(duracao_do_filme) from filme f, filme_categoria fc, categoria c 
where f.filme_id = fc.filme_id and fc.categoria_id = c.categoria_id group by nome;

/*49. qual a quantidade de filmes locados mês a mês por ano?*/
select month(data_de_aluguel), year(data_de_aluguel), count(*)
from aluguel
group by month(data_de_aluguel), year(data_de_aluguel)
order by month(data_de_aluguel), year(data_de_aluguel);

/*50. qual o total pago por classificacao de filmes alugados no ano de 2006?*/
select classificacao, sum(valor) from pagamento p, aluguel a, inventario i, filme f
where p.aluguel_id = a.aluguel_id and a.inventario_id = i.inventario_id and i.filme_id = f.filme_id and year(a.data_de_aluguel) = 2006
group by 1;

/*51. qual a média mensal do valor pago por filmes alugados no ano de 2005?*/
select month(data_de_aluguel), year(data_de_aluguel), avg(valor) from pagamento p, aluguel a, inventario i, filme f
where p.aluguel_id = a.aluguel_id and a.inventario_id = i.inventario_id and i.filme_id = f.filme_id and year(a.data_de_aluguel) = 2005
group by 2, 1;

/*52. qual o total pago por filme alugado no mês de junho de 2006 por cliente?*/
select c.primeiro_nome, sum(valor) from pagamento p, aluguel a, inventario i, filme f, cliente c
where p.aluguel_id = a.aluguel_id and a.inventario_id = i.inventario_id and i.filme_id = f.filme_id 
and p.cliente_id = c.cliente_id and year(a.data_de_aluguel) = 2006
group by 1;











