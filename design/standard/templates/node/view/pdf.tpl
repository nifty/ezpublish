{* Default template for generating PDFs from content node. *}

{let content_version=$node.contentobject_version_object
     node_name=$node.name
     children=fetch(content, list, hash( parent_node_id, $node.node_id,
                                         sort_by, $node.sort_array ) ) }

{section show=$pdf_root_template|eq(1)}
  {pdf(pageNumber, hash( identifier, "main",
                         start, 1 ) )}
{/section}

{pdf(header, hash( level, 1,
                   text, $node_name|wash(pdf),
		   size, 26,
		   align, left ) )}

{section name=ContentObjectAttribute loop=$content_version.contentobject_attributes}
  {attribute_pdf_gui attribute=$ContentObjectAttribute:item}
  {pdf(newline)}
{/section}

{section show=$tree_traverse|eq(1)}
  {section name=Child loop=$children}
    {section show=$class_array|contains($Child:item.object.contentclass_id)}
      {node_view_gui view=pdf content_node=$Child:item tree_traverse=$tree_traverse class_array=$class_array} {* Calls node/view/pdf.tpl *}
    {/section}
  {/section}
{/section}

{/let}

{section show=$pdf_root_template|eq(1)}
  {*  {pdf(createIndex)}  *} {* Index is based on the keyword datatype, and is not used in most setups *}
  {pdf(pageNumber, hash( identifier, "main",
                         stop, 1 ) )}

  {include uri="design:content/pdf/footer.tpl"}
{/section}

{* Insert frontpage *}
{section show=$show_frontpage|eq(1)}
  {pdf(frontpage, hash( text, $intro_text|wash(pdf),
                        align, center,
		 	size, 20,
			top_margin, 200 ) )}
  {pdf(frontpage, hash( text, $sub_intro_text|wash(pdf),
	                align, center,
		 	size, 14,
			top_margin, 400 ) )}
{/section}

{* generate_toc variable is only set in namespace of first instance of pdf.tpl called *}
{section show=$generate_toc|eq(1)}
  {include uri="design:content/pdf/toc.tpl"}
{/section}

