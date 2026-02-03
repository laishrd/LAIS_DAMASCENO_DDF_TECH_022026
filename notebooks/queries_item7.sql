#A descrição é longa o suficiente para possibilitar extração de informações?

SELECT
  CASE
    WHEN LENGTH(text) < 200 THEN 'Curta (<200)'
    WHEN LENGTH(text) BETWEEN 200 AND 500 THEN 'Média (200–500)'
    ELSE 'Longa (>500)'
  END AS tamanho_descricao,
  COUNT(*) AS quantidade_produtos
FROM public.TB__9IQ9KX__PRODUCTS_AND_DESCRIPTIONS
WHERE text IS NOT NULL AND TRIM(text) <> ''
GROUP BY tamanho_descricao
ORDER BY quantidade_produtos DESC;

#Existem produtos duplicados? Quantos e quais?

SELECT
  title AS produto,
  text AS descricao_produto,
  COUNT(*) AS ocorrencias
FROM public.TB__9IQ9KX__PRODUCTS_AND_DESCRIPTIONS
GROUP BY title, text
HAVING COUNT(*) > 1
ORDER BY ocorrencias DESC;

#O crescimento do catálogo de produtos ocorre de maneira homogênea?

SELECT
  CASE
    WHEN docid BETWEEN 1 AND 50000 THEN 'Lote 1'
    WHEN docid BETWEEN 50001 AND 100000 THEN 'Lote 2'
    WHEN docid BETWEEN 100001 AND 150000 THEN 'Lote 3'
    WHEN docid BETWEEN 150001 AND 200000 THEN 'Lote 4'
    ELSE 'Lote 5'
  END AS lotes_de_adicao,
  COUNT(*) AS quantidade_produtos
FROM public.TB__9IQ9KX__PRODUCTS_AND_DESCRIPTIONS
GROUP BY lotes_de_adicao
ORDER BY lotes_de_adicao;

#Qual a quantidade de itens por categoria?

SELECT
  CASE
    WHEN LOWER(title) LIKE '%phone%' OR LOWER(title) LIKE '%samsung%' THEN 'Eletronicos'
    WHEN LOWER(title) LIKE '%bra%' OR LOWER(title) LIKE '%shirt%' OR LOWER(title) LIKE '%sleeve%' THEN 'Roupas'
    WHEN LOWER(title) LIKE '%case%' OR LOWER(title) LIKE '%wallet%' THEN 'Acessorios'
    WHEN LOWER(title) LIKE '%makeup%' OR LOWER(title) LIKE '%beauty%' THEN 'Beleza'
	WHEN LOWER(title) LIKE '%stove%' OR LOWER(title) LIKE '%microwave%' OR LOWER(title) LIKE '%fridge%' OR LOWER(title) LIKE '%oven%' THEN 'Eletrodomesticos'
    ELSE 'Outros'
  END AS categoria,
  COUNT(*) AS quantidade_produtos
FROM public.TB__9IQ9KX__PRODUCTS_AND_DESCRIPTIONS
GROUP BY categoria
ORDER BY quantidade_produtos DESC;

#Qual a quantidade de produtos sem e com descrição?

SELECT
  CASE
    WHEN text IS NULL OR TRIM(text) = '' THEN 'Sem descrição'
    ELSE 'Com descrição'
  END AS status_descricao,
  COUNT(*) AS quantidade_produtos
FROM public.TB__9IQ9KX__PRODUCTS_AND_DESCRIPTIONS
GROUP BY status_descricao;
