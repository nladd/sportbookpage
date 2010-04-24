
require 'rubygems'
require 'xml/libxml'
require RAILS_ROOT + '/app/models/model_helpers.rb'

class ArticleController < ApplicationController



  #############################################################################
  # Description
  #   Show an article
  #
  #############################################################################
  def article
  
    document_id = params['document_id']
    @drop_id = params['drop_id']
    @prev_partial = params['prev_partial']
    @dragged_id = params['dragged_id']
    
    @title = "No Title"
    @abstract = ""
    
    document = DocumentContent.find_by_document_id(document_id)
    if (document.blank?) then
      @content = "Article not found. Please check back later"
    else
      article_path = FEEDFETCHER_ARCHIVE + document.sportsml
      parser = XML::Parser.file(article_path)
      article_xml = parser.parse

      if (@title = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1'))
        @title = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1').content
      end
      if (article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract'))
        @abstract = article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract').content
      end
      
      @content = article_xml.find_first('//sports-content/article/nitf/body/body.content').inner_xml
    end
    
    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", "")
                page.replace_html (@drop_id, :partial => 'article')
                page.replace_html("#{@drop_id}_side_bar", "")
    }
      
  end
  
  
  #############################################################################
  # Description
  #   Find and display the preview for a given event
  #
  #############################################################################
  def event_preview
  
    event_id = params['event_id']
    @drop_id = params['drop_id']
    @prev_partial = params['prev_partial']
    @dragged_id = params['dragged_id']
    
    @title = "No Title"
    @abstract = ""
    
    preview = Document.get_event_docs_by_fixture_key(event_id, 'pre-event-coverage', nil, 1)
    if preview.blank? then
      @title = ""
      @content = "Event preview not yet available. Please check again soon."
    else
      preview = preview[0]
      article_path = FEEDFETCHER_ARCHIVE + preview.sportsml
      parser = XML::Parser.file(article_path)
      article_xml = parser.parse
      
      if (@title = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1'))
        @title = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1').content
      end
      if (article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract'))
        @abstract = article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract').content
      end

      if (notes = article_xml.find_first('//sports-content/article/nitf/body/body.content/note'))
        notes.remove!
      end    
      @content = article_xml.find_first('//sports-content/article/nitf/body/body.content').inner_xml
    end


    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", "")                
                page.replace_html (@drop_id, :partial => 'article')
                page.replace_html("#{@drop_id}_side_bar", "")
    }
      
  end
  
  
  
  #############################################################################
  # Description
  #   Find and display the recap for a given event
  #
  #############################################################################
  def event_recap
  
    event_id = params['event_id']
    @drop_id = params['drop_id']
    @prev_partial = params['prev_partial']
    @dragged_id = 'scoreboard'
    
    @title = "No Title"
    @abstract = ""
    
    recap = Document.get_event_docs_by_fixture_key(event_id, 'post-event-coverage', nil, 1)
    if recap.blank? then
      @title = ""
      @content = "Event summary not yet available. Please check again soon."
    else
      recap = recap[0]
      article_path = FEEDFETCHER_ARCHIVE + recap.sportsml
      parser = XML::Parser.file(article_path)
      article_xml = parser.parse
      
      if (@title = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1'))
        @title = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1').content
      end
      if (article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract'))
        @abstract = article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract').content
      end

      if (notes = article_xml.find_first('//sports-content/article/nitf/body/body.content/note'))
        notes.remove!
      end    
      @content = article_xml.find_first('//sports-content/article/nitf/body/body.content').inner_xml
    end
    

    
    render(:update) {|page|
                page.replace_html(@drop_id + "_title", "")
                page.replace_html (@drop_id, :partial => 'article')
                page.replace_html("#{@drop_id}_side_bar", "")
    }
      
  end


end
