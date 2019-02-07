﻿Shader "Stylised Shadows/Mesh Blob Shadow"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			Tags {"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			float4 _PlaneNormal;

			v2f vert(appdata v)
			{
				v2f o;

				// In ForwardBase light mode _WorldSpaceLightPos0 is always direction light
				float4 worldLightDirection = -normalize(_WorldSpaceLightPos0);
				
				// Calculate vertex offset
				float planeNormalDotLightDir = dot(_PlaneNormal, worldLightDirection);
				float planeNormalDotWorldVertex = dot(_PlaneNormal, mul(unity_ObjectToWorld, v.vertex));
				float3 worldVertexToPlaneVector = worldLightDirection * (planeNormalDotWorldVertex / (-planeNormalDotLightDir));

				// Add vertex offset in local coordinates before applying final transformation
				o.vertex = UnityObjectToClipPos(v.vertex + mul(unity_WorldToObject, worldVertexToPlaneVector));

				// Apply fog
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = _Color;

				// Apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
		Fallback "Legacy Shaders/Diffuse"
}
