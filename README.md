# LAIS_DAMASCENO_DDF_TECH_022026
Case técnico Dadosfera - Analista de Dados.

---

## Introdução

Este repositório contém a entrega do **Case Técnico da Dadosfera**, com foco em carregamento, catalogação, análise exploratória e qualidade de dados, utilizando um conjunto de dados de produtos e suas descrições.
O objetivo principal do case é demonstrar a capacidade de trabalhar com dados desestruturados, aplicar boas práticas de governança e responder perguntas analíticas relevantes por meio de consultas SQL e visualizações.

---

## Item 1 - Sobre a base de dados

Para o desenvolvimento deste case foi selecionado um conjunto de dados de produtos e suas descrições textuais, alinhado ao cenário proposto de uma empresa de e-commerce que busca centralizar dados e gerar análises descritivas e prescritivas com maior agilidade.

A escolha dessa base de dados se justifica por:
- Estar relacionada ao cenário de uma empresa de e-commerce, conforme proposto;
- Possuir alto volume de dados;
- Ser composta majoritariamente por dados desestruturados;
- Ter potencial para análises de referentes a qualidade de dados, análise de duplicidade de produtos e evolução do catálogo.

O dataset utilizado é o Product Search Corpus, disponibilizado publicamente no Hugging Face (`spacemanidol/product-search-corpus`), mais especificamente o arquivo **corpus-simple.jsonl**. Ele contém registros de produtos, com foco em informações textuais.

Algumas características do arquivo escolhido são:
- Volume original: aproximadamente **2GB**
- Formato original: **JSON**
- Estrutura: `docid`, `title` e `text`.

Para fins analíticos e de governança, o conjunto de dados foi convertido para um formato tabular: **CSV**. O conteúdo textual e a estrutura original forma mantidos, a única modificação foi a limitação dos registros em **150.000**. 

## Item 2 - Sobre a Dadosfera - Integrar

Nesta etapa do case foi realizada a integração dos dados na plataforma Dadosfera, utilizando o módulo de coleta (´Importar arquivos´) para disponibilizar o conjunto de dados de produtos na plataforma.

O objetivo principal desta fase é garantir que os dados estejam acessíveis e disponíveis para catalogação.

O dataset, previamente convertido para o formato CSV, foi carregado na Dadosfera respeitando o volume de 150.000 registros, respeitando o mínimo exigido pelo case (mais de 100.000 registros).

Após a importação:
- O conjunto de dados ficou disponível como uma tabela CSV;
- O dataset pôde ser catalogado e documentado nas etapas seguintes;
- E utilizado para análises em etapas futuras.

**Link para o conjunto de dados integrado na Dadosfera:**  
`https://app.dadosfera.ai/pt-BR/collect/import-files/fd5df53c-3f31-4c70-b8c9-2b928be3e9be`

**Print do conjunto de dados integrado na Dadosfera:**  
![Preview do dataset na Dadosfera](prints/Item2.png)

## Item 3 - Sobre a Dadosfera - Explorar

Após a integração dos dados, foi realizada a etapa de exploração e catalogação, com o objetivo de tornar o dataset compreensível, governável e reutilizável dentro da plataforma Dadosfera. Algo fundamental, pois transforma dados brutos em conjuntos de dados bem documentados, facilitando análises futuras, compartilhamento e escalabilidade.

O conjunto de dados foi catalogado na Dadosfera com as seguintes informações:
- Nome do dataset: Products and Descriptions  
- Descrição: O conjunto de dados contém informações a respeito de cada produto e sua descrição, sendo utilizado para o case técnico. Os dados foram obtidos no formato JSON no huggingface (spacemanidol/product-search-corpus), posteriormente convertidos para o formato CSV e limitado a 150.000 registros.
- Zona: Landing / Raw (de acordo com as definições de um datalake)
- Tipo de dado: Dados desestruturados (texto)   

Para documentar as colunas disponíveis, a seguir é apresentado um Dicionário de Dados:

| Coluna | Tipo | Descrição |
|------|------|-----------|
| docid | Inteiro | Identificador único do produto |
| title | Texto | Título ou nome do produto |
| text | Texto | Descrição detalhada do produto |

**Link para o dataset catalogado na Dadosfera:**  
`https://app.dadosfera.ai/pt-BR/catalog/data-assets/201eb22a-709e-454e-86ad-87fe4e1f4bc2`

**Print do conjunto de dados catalogado na Dadosfera:**  
![Preview do dataset na Dadosfera](prints/Item3.png)


## Item 4 - Sobre Data Quality

Após a integração e catalogação dos dados, foi realizada uma análise de Qualidade de Dados, com o objetivo de identificar inconsistências e lacunas que possam impactar negativamente análises analíticas e a experiência de compra em um cenário de e-commerce.

Para esta etapa foi utilizada a biblioteca Great Expectations, executada em ambiente Google Colab. A escolha da Great Expectations se justifica pelo seu fácil manuseio e extração simples de documentação.

**A análise de qualidade teve como foco os seguintens aspectos:**

1. Presença de dados nulos
   Avaliação da existência de campos ausentes ou vazias em cada coluna, uma vez que dados nulos podem comprometer: as chaves primárias dos registros, o manuseio do banco de dados, a identificação dos produtos e a gestão dos dados. Foi identificada uma parcela significativa de registros com descrição ou título nulo.
   
2. Presença de dados duplicados
    Avaliação da existência de dados duplicados em cada coluna, uma vez que tais casos podem indicar produtos duplicados, o que pode causar mau funcionamento do site e problemas de gestão de estoque do e-commerce. Nesta etapa foram identificados dados duplicados.
   
3. Tamanho da descrição dos produtos
    Avaliação do tamanho da descrição dos produtos, o que pode indicar se a descrição é longa o suficiente para extração de informações, tanto pelo cliente quanto por ferramentas de manipulação de dados. Foram encontradas descrições com tamanho abaixo do esperado.
   
4. Descrição inválida ou incompleta
  Avaliação sobre o conteúdo das descrições do produtos, se existem valores genéricos ou vazios, como "Product Description", "N/A" ou "". Desta maneira é possível checar a qualidade das descrições e se elas estão agregando valor analítico ou comercial. Alguns casos indesejados foram identificados.

**Melhoria da qualidade dos dados:**

Após a identificação das inconsistências e dados faltantes, a melhoria da qualidade dos dados seria conduzida de forma incremental, com foco em governança, padronização e monitoramento.

Inicialmente, as regras de qualidade seriam formalizadas como validações recorrentes, permitindo que novos dados integrados à plataforma passem automaticamente por verificações de integridade, unicidade e completude. Esse processo garante que problemas já identificados, como descrições ausentes, valores genéricos ou dados duplicados, sejam detectados precocemente.

Para os casos de dados nulos ou incompletos, seriam adotadas estratégias de tratamento conforme o impacto no negócio. Registros críticos podem ser sinalizados para correção no momento de inserção dos dados. No caso de dados duplicados, a padronização de chaves e a definição de critérios para remover duplicados permitem melhorar a consistência do catálogo de produtos, reduzindo problemas operacionais e melhorando a experiência do cliente no e-commerce.

Por fim, a documentação das regras de qualidade seria integrada aos dados, promovendo maior transparência e alinhamento entre áreas. O que garante não apenas a correção pontual dos problemas identificados, mas também a sustentabilidade da qualidade dos dados ao longo do tempo.

**Notebook de Qualidade de Dados:**  
`notebooks/item4_case_dadosfera.ipynb`

**Link do notebook de Qualidade de Dados no Google Colab:**  
`https://colab.research.google.com/drive/14Ws3vpeNcaoepQmjawPfCuQGcx6fVJ6Z?usp=sharing`

**Relatório gerado pelo notebook de Qualidade de Dados:**  
`notebooks/relatorio_item4.json`

**Print do Relatório de Qualidade dos Dados após execução do notebook:**  
![Preview do relatorio no colab](prints/Item4.png)

## Item 7 - Sobre Análise de Dados - Analisar

Por meio da análise a seguir buscou-se gerar valor a partir dos dados integrados na plataforma Dadosfera, utilizando consultas SQL e visualizações para apoiar decisões relacionadas ao catálogo de produtos do e-commerce em questão.

O dashboard consolidado permite uma visão analítica do estado atual do catálogo de produtos, facilitando a identificação de problemas que impactam diretamente: experiência de compra dos clientes, eficiência de mecanismos de busca, performance de análises baseadas nas informações, governança e confiabilidade dos dados.

**Análises realizadas**

1. A descrição é longa o suficiente para possibilitar extração de informações?

Esta análise avalia o comprimento das descrições dos produtos, verificando se elas possuem tamanho adequado para fornecer informações relevantes tanto aos clientes quanto a processos analíticos. Para visualizar está análise foi utilizado o gráfico de barras horizontais/linhas.

Valor gerado:
Permite identificar descrições excessivamente curtas, que podem comprometer a compreensão do produto, reduzir a taxa de conversão e limitar a extração de atributos por ferramentas analíticas e modelos de IA.

2. Existem produtos duplicados? Quantos e quais?

Nesta análise foi verificada a existência de produtos duplicados no catálogo, considerando a combinação entre título e descrição. Para visualizar está análise foi utilizada a tabela.

Valor gerado:
A identificação de duplicidades auxilia na limpeza e padronização do catálogo, evitando inconsistências de estoque e confusão na apresentação dos produtos ao cliente final.

3. O crescimento do catálogo de produtos ocorre de maneira homogênea?

Como o conjunto de dados não possui informações temporais, foi criada uma simulação de série temporal por meio de lotes sequenciais de adição de dados para permitir análise temporal da evolução do catálogo de produtos. Para visualizar está análise foi utilizado o gráfico de linha.

Valor gerado:
Essa análise permite identificar padrões de ingestão de dados, como cargas concentradas em determinados períodos e auxiliando na compreensão do comportamento do crescimento do catálogo.

4. Qual a quantidade de itens por categoria?

A análise apresenta a distribuição de produtos por categoria, permitindo avaliar a distribuição dos itens no catálogo. Para está análise de categorias foram criados alguns exemplos de categorias, de acordo com as informações presentes dos dados. Para visualizar está análise foi utilizado o gráfico de barras.

Valor gerado:
Ajuda a identificar categorias com maior volume de produtos, possíveis desequilíbrios no catálogo e apresenta oportunidades de melhoria na organização e classificação dos itens.

5. Qual a quantidade de produtos com e sem descrição?

Esta análise compara a quantidade de produtos que possuem descrição preenchida com aqueles que não possuem, evidenciando o nível de completude do catálogo. Para visualizar está análise foi utilizado o gráfico de pizza.

Valor gerado:
A falta de descrição impacta diretamente a experiência do usuário, mecanismos de busca e modelos de recomendação. 

Por fim, é possível observar que o dashboard criado serve como base para:
- Monitoramento contínuo da qualidade do catálogo;
- Apoio à tomada de decisão;
- Suporte a iniciativas analíticas e de novos modelos.

**Link para o dashboard presente na Dadosfera:**  
`https://metabase-treinamentos.dadosfera.ai/collection/1048-lais-damasceno-022026` - pasta Lais Damasceno - 022026
`http://metabase-treinamentos.dadosfera.ai/public/dashboard/fe5443cd-b079-4746-8102-4fb9cdbda0e9` - dashboard

**Queries SQL utilizadas para gerar as visualizações:**  
`notebooks/queries_item7.sql`

**Print das questões/queries na Dadosfera:**  
![Preview do dash na Dadosfera](prints/Item7p1.png)

**Print do dashboard na Dadosfera:**  
![Preview do dashboard na Dadosfera](prints/Item7p2.png)


---

## Conclusão

O e-commerce atualmente apresenta arquitetrura de dados baseada em múltiplos serviços, o que pode aumentar a complexidade operacional, ter custo elevado, demandar tempo e esforço extras. Ao desenvolver o case ficou claro que a Dadosfera pode substituir a arquitetura atual, simplificando o caminho entre dados e valor e permitindo centralizar em apenas uma plataforma diversos serviços.

Quanto à viabilidade técnica a Dadosfera permite a centralização de atividades como: integração de grandes volumes de dados, catalogação de conjuntos de dados, monitoramento contínuo, geração de análises relevantes por meio de SQL e dashboards. Esta centralização também apresenta benefícios em relação à viabilidade econômica, como, redução de custos de infraestrutura distribuída, redução de custos operacionais de manutenção e diminuição no tempo de importação de dados à geração de valor.

Como oportunidades de ganhos futuros a adoção da Dadosfera permite econômia de tempo e recursos para focar no que realmente é prioridade para o negócio, como, expansão de dados, implementação de modelos de IA e escalabilidade.




