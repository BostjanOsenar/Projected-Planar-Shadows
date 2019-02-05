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
			float4 _PlaneNormalVectorMatrix;

			v2f vert(appdata v)
			{
				v2f o;

				// In ForwardBase light mode _WorldSpaceLightPos0 is always direction light
				float4 worldLightDirection = -normalize(_WorldSpaceLightPos0);

				// Calculate the distance between the vertex and projection plane
				float vertexToPlaneDistance = dot(_PlaneNormalVectorMatrix, worldLightDirection);

				// Calculate the distance between vertex and projection plane using plane normal direction
				float vertextToPlaneNormalDistance = dot(_PlaneNormalVectorMatrix, mul(unity_ObjectToWorld, v.vertex));

				// Calculate final vertex offset by scaling world light vector
				float3 worldVertexToPlaneVector = worldLightDirection * (vertextToPlaneNormalDistance / (-vertexToPlaneDistance));

				// Clip position in local space, convert to world
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
