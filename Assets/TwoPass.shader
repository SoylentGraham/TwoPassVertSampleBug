Shader "Unlit/TwoPass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		GreenTex("GreenTex", 2D) = "blue" {}
	}

	CGINCLUDE
		#include "UnityCG.cginc"
		#pragma target 3.0

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f
		{
			float2 uv : TEXCOORD0;
			UNITY_FOG_COORDS(1)
			float4 vertex : SV_POSITION;
			float4 Colour : COLOR;
		};

		sampler2D _MainTex;
		float4 _MainTex_ST;
	ENDCG


	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

			

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			sampler2D GreenTex;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Colour = tex2Dlod( GreenTex, float4(v.uv, 0, 0) );
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.Colour;
			}
			ENDCG
		}


		Pass
		{
			CGPROGRAM
			#pragma vertex vert2
			#pragma fragment frag2
		
			v2f vert2(appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.Colour = float4(1,0,0,1);
				return o;
			}
			
			fixed4 frag2(v2f i) : SV_Target
			{
				return i.Colour;
			}
			ENDCG
		}
	}
}
