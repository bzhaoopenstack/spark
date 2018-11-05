<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">]]></xsl:text>
        <html>
            <head>
                <title>
                    Xunit Test Results - For: <xsl:value-of select="@name"/>
                </title>
                <style type="text/css">

                    .testcases {
                       border: 1px solid black;
                       padding: 10px;
                     }

                    .filters {
                        margin: 10px 0 0 0;
                     }

                    .failed {
                        display:block;
                    }

                   .failed a {
                        color: red;
                        font-weight: bold;
                    }

                    .passed {
                        display: block;
                    }

                   .passed a {
                        color: green;
                        font-weight: bold;
                    }

                    .skipped {
                        display: block;
                    }

                   .skipped a {
                        color: orange;
                        font-weight: bold;
                    }

                    .passed-message {
                        border: 1px solid green;
                    }
                    .error-message {
                        border: 1px solid red;
                    }

                </style>
                <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"/>
                <script type="text/javascript">
                  $(document).ready(function() {
                    $(".display-message").click(function() {

                    });
                    $(".filter").change(function(event) {
                        var testcaseid = event.target.id + '-cases'
                        $('#' + testcaseid + ' div').show();
                        if ( $(this).val() != 'all' ) {
                            $('#' + testcaseid + ' div[class != "' + $(this).val() + '"][class != "error-message"]').each(function() {
                                $(this).hide();
                            });
                        }
                    });
                 });
                </script>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="assemblies">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="testsuite">

        <xsl:variable name="testsuit_id" select="generate-id(current())" />
        <h3 class="divided">
            <b>Results for <xsl:value-of select="@name"/></b>
        </h3>

        <div class="container">
            Tests run: <a href="#all"><b><xsl:value-of select="@tests"/></b></a>
            Failures: <a href="#failures"><b><xsl:value-of select="@failures"/></b></a>,
            Skipped: <a href="#skipped"><b><xsl:value-of select="@skip"/></b></a>

            <div class="filters">
                <label for="filter">Filter Test cases:</label>
                <select id="{$testsuit_id}" class="filter">
                    <option name="all" value="all" selected="true">All</option>
                    <option name="passed" value="passed">Passed</option>
                    <option name="skipped" value="skipped">Skipped</option>
                    <option name="failed" value="failed">Failed</option>
                </select>
            </div>
            <hr></hr>
        </div>

        <div class="testcases" id="{$testsuit_id}-cases">
        <xsl:for-each select="testcase">
            <xsl:choose>
                <xsl:when test="not(*)">
                    <div class="passed">
                        <pre><b>Class:</b> <xsl:value-of select="@classname"/></pre>
                        <pre><b>Test Name:</b> <xsl:value-of select="@name"/></pre>
                        <pre><b>Running Time:</b> <xsl:value-of select="@time"/></pre>
                        <pre><b>State:</b><a>Passed</a></pre>
                    <hr></hr>
                   </div>
                </xsl:when>
                <xsl:when test="skipped">
                    <div class="skipped">
                        <pre><b>Class:</b> <xsl:value-of select="@classname"/></pre>
                        <pre><b>Test Name:</b> <xsl:value-of select="@name"/></pre>
                        <pre><b>Running Time:</b> <xsl:value-of select="@time"/></pre>
                        <pre><b>State:</b><a>Skipped</a></pre>
                    <hr></hr>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div class="failed">
                        <pre><b>Class:</b> <xsl:value-of select="@classname"/></pre>
                        <pre><b>Test Name:</b> <xsl:value-of select="@name"/></pre>
                        <pre><b>Running Time:</b> <xsl:value-of select="@time"/></pre>
                        <pre><b>State:</b><a>Failed</a></pre>
                        <xsl:for-each select="failure">
                            <div class="error-message">
                                <pre><a class="display-message"> Error Message</a></pre>
                                <xsl:value-of select="."/>
                            </div>
                        </xsl:for-each>
                    <hr></hr>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        </div>

    </xsl:template>

</xsl:stylesheet>
