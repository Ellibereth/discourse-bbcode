require 'rails_helper'

describe PrettyText do

  it 'can apply color bbcode' do
    cooked = PrettyText.cook "hello [color=red]RED[/color] world"
    html = '<p>hello <font color="red">RED</font> world</p>'

    expect(cooked).to eq(html)
  end

  it 'can apply size bbcode' do
    cooked = PrettyText.cook "hello [size=100]BIG[/size] text"
    html = '<p>hello <font size="100">BIG</font> text</p>'

    expect(cooked).to eq(html)
  end

  it 'can apply font bbcode' do
    cooked = PrettyText.cook "hello [font=usa]usa[/font] text"
    html = '<p>hello <font face="usa">usa</font> text</p>'

    expect(cooked).to eq(html)
  end

  it 'can apply small bbcode' do
    cooked = PrettyText.cook "hello [small]usa[/small] text"
    html = '<p>hello <span style="font-size:x-small">usa</span> text</p>'

    expect(cooked).to eq(html)
  end

  it 'can apply highlight bbcode' do
    cooked = PrettyText.cook "hello [highlight]highlight[/highlight] text"
    html = '<p>hello <span class="highlight">highlight</span> text</p>'

    expect(cooked).to eq(html)
  end
    
  it 'can apply v bbcode' do
    cooked = PrettyText.cook "[v]name[/v]"
    html = '<p><span class="highlight"><b>VOTE: name</b></span></p>'

    expect(cooked).to eq(html)
  end

  it 'can apply vote bbcode' do
    cooked = PrettyText.cook "[vote]name[/vote]"
    html = '<p><span class="highlight"><b>VOTE: name</b></span></p>'

    expect(cooked).to eq(html)
  end
  
  it 'can apply unvote bbcode' do
    cooked = PrettyText.cook "[unvote]name[/unvote]"
    html = '<p><span class="highlight"><b>UNVOTE name</b></span></p>'

    expect(cooked).to eq(html)
  end

  it 'can apply uv bbcode' do
    cooked = PrettyText.cook "[uv]name[/uv]"
    html = '<p><span class="highlight"><b>UNVOTE name</b></span></p>'

    expect(cooked).to eq(html)
  end
  
  it 'can apply reset bbcode' do
    cooked = PrettyText.cook "[reset]vote[/reset]"
    html = '<p><span class="highlight"><b>RESET vote</b></span></p>'

    expect(cooked).to eq(html)
  end

  it 'can apply left center and right' do
    markdown = <<~MD
    [left]
    I am aligned to the left

    **yay**
    [/left]

    [center]

    I am in the *middle*

    [/center]

    [right]

    and I am too the right

    [/right]
    MD
    cooked = PrettyText.cook markdown
    html = <<~HTML
      <div style="text-align:left">
      <p>I am aligned to the left</p>
      <p><strong>yay</strong></p>
      </div>
      <div style="text-align:center">
      <p>I am in the <em>middle</em></p>
      </div>
      <div style="text-align:right">
      <p>and I am too the right</p>
      </div>
    HTML

    expect(cooked).to eq(html.strip)
  end

  it "supports edit and ot, indent" do
    markdown = <<~MD
      [ot]
      test
      [/ot]

      [edit]
      i am edit
      [/edit]

      [indent]
      test
      [/indent]
    MD

    cooked = PrettyText.cook(markdown)

    html = <<~HTML
      <div class="sepquote">
      <span class="smallfont">Off Topic:</span>
      <br>
      <br>
      <p>test</p>
      </div>
      <div class="sepquote">
      <span class="smallfont">Edit:</span>
      <br>
      <br>
      <p>i am edit</p>
      </div>
      <blockquote class="indent">
      <p>test</p>
      </blockquote>
    HTML

    expect(cooked).to eq(html.strip)
  end

  it "supports aname and jumpto" do
    markdown = <<~MD
      [aname=bob]I am an anchor[/aname]

      [jumpto=bob]I am a href jump to[/jumpto]
    MD

    cooked = PrettyText.cook(markdown)
    html = <<~HTML
     <p><a name="bob">I am an anchor</a></p>
     <p><a href="#bob">I am a href jump to</a></p>
    HTML

    expect(cooked).to eq(html.strip)
  end

  it "supports the nightmare bbcode list" do
    markdown = <<~MD
      [list=A]
      [*] I am an **item**
      [*] I am another **item**
      [/list]

      [list]
      [*] I am an **item**
      [*] I am another **item**
      [/list]

      [ol]
      *another item
      [*]and yet another
      [/ol]

      [ul]

         [li]this is an item[/li]

      *mix and match
      and do multiline cause why not

      even multi paragraph?

      [*]mix

      [/ul]

      [list]
      this is an invalid list
      [/list]

    MD

    html = <<~HTML
      <ol type="A">
      <li> I am an <strong>item</strong>
      </li>
      <li> I am another <strong>item</strong>
      </li>
      </ol>
      <ul>
      <li> I am an <strong>item</strong>
      </li>
      <li> I am another <strong>item</strong>
      </li>
      </ul>
      <ol>
      <li>another item</li>
      <li>and yet another</li>
      </ol>
      <ul>
      <li>
      <li>this is an item<br>
      </li>
      <li>mix and match<br>
      and do multiline cause why not<br>
      <br>
      even multi paragraph?<br>
      </li>
      <li>mix<br>
      </li>
      </ul>
      <ul>
      <li>this is an invalid list</li>
      </ul>
    HTML

    cooked = PrettyText.cook markdown
    expect(cooked).to eq(html.strip)
  end

end
