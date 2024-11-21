
--Laboratório 1


--A – Realizando consultas e ordenando dados

--1. Coloque em uso o banco de dados PEDIDOS;
 USE PEDIDOS
 
 
--2. Calcule a média de preço de venda (PRECO_VENDA) do cadastro de TB_PRODUTO;
 SELECT AVG(PRECO_VENDA) AS PRECO_MEDIO
 FROM TB_PRODUTO
 
 
--3. Calcule a quantidade de pedidos cadastrados em janeiro de 2018 (o maior e o menor valor total, VLR_TOTAL);
 SELECT COUNT(*) AS QTD_PEDIDOS,
       MAX(VLR_TOTAL) AS MAIOR_PEDIDO,
       MIN(VLR_TOTAL) AS MENOR_PEDIDO
 FROM TB_PEDIDO
 WHERE DATA_EMISSAO BETWEEN '2018.1.1' AND '2018.1.31'
 
 

--4. Calcule o valor total vendido (soma de TB_PEDIDO.VLR_TOTAL) em janeiro de 2016;
 SELECT SUM(VLR_TOTAL) AS TOT_VENDIDO
 FROM TB_PEDIDO
 WHERE DATA_EMISSAO BETWEEN '2016.1.1' AND '2016.1.31'

 
--5. Calcule o valor total vendido pelo vendedor de código 4 em janeiro de 2017;
 SELECT SUM(VLR_TOTAL) AS TOT_VENDIDO
 FROM TB_PEDIDO
 WHERE DATA_EMISSAO BETWEEN '2017.1.1' AND '2017.1.31' AND
      CODVEN = 4

	  
--6. Calcule o valor total vendido pela vendedora LEIA em janeiro de 2018;
 SELECT SUM(PED.VLR_TOTAL) AS TOT_VENDIDO
 FROM TB_PEDIDO PED 
INNER JOIN TB_VENDEDOR VEND
 ON VEND.CODVEN = PED.CODVEN
 WHERE PED.DATA_EMISSAO BETWEEN '2018.1.1' AND '2018.1.31' 
  AND VEND.NOME = 'LEIA'

  
--7. Liste os totais vendidos por vendedor (mostrar TB_VENDEDOR.NOME e a soma de TB_PEDIDO.VLR_TOTAL) 
--em janeiro de 2017. Deve-se exibir o nome do vendedor;
 SELECT VEND.NOME
     , SUM(PED.VLR_TOTAL) AS TOT_VENDIDO
 FROM TB_PEDIDO PED 
INNER JOIN TB_VENDEDOR VEND
 ON PED.CODVEN=VEND.CODVEN
 WHERE PED.DATA_EMISSAO BETWEEN '2017.1.1' AND '2017.1.31'
 GROUP BY VEND.NOME

 
--8. Liste o total comprado por cliente em janeiro de 2017. Deve-se mostrar o nome do cliente;
 SELECT CLI.CODCLI
     , CLI.NOME
     , SUM(PED.VLR_TOTAL) AS TOT_COMPRADO
 FROM TB_PEDIDO PED
 INNER JOIN TB_CLIENTE CLI
 ON PED.CODCLI = CLI.CODCLI
 WHERE PED.DATA_EMISSAO BETWEEN '2017.1.1' AND '2017.1.31'
 GROUP BY CLI.CODCLI, CLI.NOME

 
--9. Liste o valor e a quantidade total vendida de cada produto em janeiro de 2017;
 SELECT PROD.ID_PRODUTO
     , PROD.DESCRICAO
     , SUM( ITEM.QUANTIDADE ) AS QTD_TOTAL
     , SUM( ITEM.PR_UNITARIO * ITEM.QUANTIDADE ) AS VLR_TOTAL
 FROM TB_ITENSPEDIDO ITEM
 INNER JOIN TB_PRODUTO PROD
 ON ITEM.ID_PRODUTO = PROD.ID_PRODUTO
 INNER JOIN TB_PEDIDO PED
 ON ITEM.NUM_PEDIDO = PED.NUM_PEDIDO
 WHERE PED.DATA_EMISSAO BETWEEN '2017.1.1' AND '2017.1.31'
 GROUP BY PROD.ID_PRODUTO, PROD.DESCRICAO

 
--10. Liste os totais vendidos por vendedor em janeiro de 2018. Deve-se exibir o nome do vendedor e
--devem ser mostrados apenas os vendedores que venderam mais de R$40.000,00;
 SELECT VEND.CODVEN
     , VEND.NOME
  , SUM(PED.VLR_TOTAL) AS TOT_VENDIDO
 FROM TB_PEDIDO PED 
INNER JOIN TB_VENDEDOR VEND
 ON PED.CODVEN = VEND.CODVEN
 WHERE PED.DATA_EMISSAO BETWEEN '2018.1.1' AND '2018.1.31'
 GROUP BY VEND.CODVEN
       , VEND.NOME
 HAVING SUM(PED.VLR_TOTAL) > 40000
 ORDER BY 3

 
--11. Liste o total comprado por cliente em janeiro de 2019. Deve-se mostrar o nome do cliente e devem ser exibidos somente
--os clientes que compraram mais de R$6.000,00;
 SELECT CLI.CODCLI
     , CLI.NOME
     , SUM(PED.VLR_TOTAL) AS TOT_COMPRADO
 FROM TB_PEDIDO PED
 INNER JOIN TB_CLIENTE CLI 
ON PED.CODCLI = CLI.CODCLI
 WHERE PED.DATA_EMISSAO BETWEEN '2019.1.1' AND '2019.1.31'
 GROUP BY CLI.CODCLI, CLI.NOME
 HAVING SUM(PED.VLR_TOTAL) > 6000
 ORDER BY 3

 
--12. Liste o total vendido de cada produto em janeiro de 2018. Devem ser mostrados apenas os produtos que 
--venderam mais de R$16.000,00;
 SELECT PROD.ID_PRODUTO
     , PROD.DESCRICAO
     , SUM( ITEM.PR_UNITARIO * ITEM.QUANTIDADE ) AS VLR_TOTAL
 FROM TB_ITENSPEDIDO ITEM
 INNER JOIN TB_PRODUTO PROD 
ON ITEM.ID_PRODUTO = PROD.ID_PRODUTO
 INNER JOIN TB_PEDIDO PED
 ON ITEM.NUM_PEDIDO = PED.NUM_PEDIDO
 WHERE PED.DATA_EMISSAO BETWEEN '2018.1.1' AND '2018.1.31'
 GROUP BY PROD.ID_PRODUTO, PROD.DESCRICAO
 HAVING SUM( ITEM.PR_UNITARIO * ITEM.QUANTIDADE ) > 16000
 ORDER BY 3;

 
--13. Liste o total comprado por cada cliente em janeiro de 2017. Deve-se mostrar o nome do cliente 
--e devem ser exibidos somente os 10 primeiros do ranking;
 SELECT TOP 10 
      CLI.CODCLI
     ,CLI.NOME
     ,SUM(PED.VLR_TOTAL) AS TOT_COMPRADO
 FROM TB_PEDIDO PED
 INNER JOIN TB_CLIENTE CLI
 ON PED.CODCLI = CLI.CODCLI
 WHERE PED.DATA_EMISSAO BETWEEN '2017.1.1' AND '2017.1.31'
 GROUP BY CLI.CODCLI, CLI.NOME
 ORDER BY 3 DESC

--14. Liste o total vendido de cada produto em janeiro de 2016. Devem ser mostrados os 10 produtos que mais venderam;
 SELECT TOP (10)
       PROD.ID_PRODUTO
     , PROD.DESCRICAO
     , SUM(ITEM.QUANTIDADE) AS QTD_TOTAL
     ,SUM( ITEM.PR_UNITARIO * ITEM.QUANTIDADE ) AS VLR_TOTAL
 FROM TB_ITENSPEDIDO ITEM
 INNER JOIN TB_PRODUTO PROD 
ON ITEM.ID_PRODUTO = PROD.ID_PRODUTO
 INNER JOIN TB_PEDIDO PED
 ON ITEM.NUM_PEDIDO = PED.NUM_PEDIDO
 WHERE PED.DATA_EMISSAO BETWEEN '2016.1.1' AND '2016.1.31'
  GROUP BY PROD.ID_PRODUTO
     , PROD.DESCRICAO
 ORDER BY 4 DESC

 
--15. Liste o total vendido em cada um dos meses de 2017.
 SELECT MONTH( DATA_EMISSAO ) AS MES,
       YEAR( DATA_EMISSAO ) AS ANO,
       SUM( VLR_TOTAL ) AS TOT_VENDIDO
 FROM TB_PEDIDO
 WHERE YEAR(DATA_EMISSAO) = 2017
 GROUP BY MONTH( DATA_EMISSAO ), YEAR( DATA_EMISSAO )
 ORDER BY MÊS
 
 
 
 
