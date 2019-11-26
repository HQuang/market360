<!-- BEGIN: main -->
<ul class="block_topic">
	<!-- BEGIN: loop -->
	<li>
		<h2><a href="{DATA.link_view}" title="{DATA.title}">{DATA.title0}</a></h2>
		 <span class="text-muted">{DATA.addtime} - {DATA.poster}</span>
	</li>
	<!-- END: loop -->
</ul>
<!-- END: main -->

<!-- BEGIN: config -->
<tr>
	<td>{LANG.type}</td>
	<td>
		<select name="config_type" class="form-control w200">
			<!-- BEGIN: type -->
			<option value="{TYPE.index}" {TYPE.selected}>{TYPE.value}</option>
			<!-- END: type -->
		</select>
	</td>
</tr>
<tr>
	<td>{LANG.numrow}</td>
	<td><input tyle="number" class="form-control w200" name="config_numrow" value="{DATA.numrow}" /></td>
</tr>
<tr>
	<td>{LANG.title_length}</td>
	<td><input tyle="number" class="form-control w200" name="config_title_length" value="{DATA.title_length}" /></td>
</tr>
<!-- END: config -->