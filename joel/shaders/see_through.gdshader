shader_type canvas_item;

uniform vec2 player_pos = vec2(576,324);
uniform vec2 circle;
uniform float max_distance = 75.0;

void fragment() {
	if (COLOR.a!=0.0){
		float distance_to_player = distance(FRAGCOORD.xy - vec2(player_pos.x*3.0,player_pos.y),circle + player_pos);
		COLOR.a = clamp(((distance_to_player-max_distance)/max_distance*5.0),0.3,1);
	};
}