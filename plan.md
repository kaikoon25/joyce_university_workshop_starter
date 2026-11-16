Plan
- Write questions, entities, grain, and expected outputs
- You can place these in a top-level plan.md file in your project

Develop
- Add staging, marts (and, optionally, intermediate) models with clear naming and layering

Test
- Add tests early, document columns and models whilst you're in the YAML files

Deploy
- Ensure everything builds end-to-end locally and push changes to main

Operate (optional for workshop)
- Schedule your project to run via a job (optionally, schedule it) on dbt Platform

Observe
- Check lineage and data quality signals via test results

Discover
- Add any additional useful descriptions and documentation to the project, models, and columns.

Analyze
- Query your marts (or build an output artifact) and write 1–2 insights plus next steps

----

Which products and stores are most profitable?

- Which product types have the highest gross margin and margin % (total return)
- Which stores return the most value?
- How much profit comes from perishable vs non-perishable products?
- Something about dates and profit (what time of the year returns the most profit) (could add within another model)