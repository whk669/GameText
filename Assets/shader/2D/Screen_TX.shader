// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXUI/2D/Screen_TX"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0

        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Src("BlendRGB_Src", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Dst("BlendRGB_Dst", Float) = 0
        [HDR]_MainTex_Color("MainTex_Color", Color) = (1,1,1,1)
        _Color_int("Color_int", Float) = 1
        _UVTillingOffset("UVTillingOffset", Vector) = (1,1,0,0)
        _MainTex_Panner("MainTex_Panner", Vector) = (0,0,1,0)
        _MainTex_001("MainTex_001", 2D) = "white" {}
        _MaskTex_001("MaskTex_001", 2D) = "white" {}
        _Alpha_Int("Alpha_Int", Float) = 1
        [HideInInspector] _texcoord( "", 2D ) = "white" {}

    }

    SubShader
    {
		LOD 0

        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

        Stencil
        {
        	Ref [_Stencil]
        	ReadMask [_StencilReadMask]
        	WriteMask [_StencilWriteMask]
        	Comp [_StencilComp]
        	Pass [_StencilOp]
        }


        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

        
        Pass
        {
            Name "Default"
        CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            #include "UnityShaderVariables.cginc"


            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                float4  mask : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
                float4 ase_texcoord3 : TEXCOORD3;
            };

            sampler2D _MainTex;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;
            float _UIMaskSoftnessX;
            float _UIMaskSoftnessY;

            uniform float _BlendRGB_Src;
            uniform float _BlendRGB_Dst;
            uniform sampler2D _MainTex_001;
            uniform float4 _MainTex_Panner;
            uniform float4 _UVTillingOffset;
            uniform sampler2D _MaskTex_001;
            uniform float4 _MaskTex_001_ST;
            uniform float4 _MainTex_Color;
            uniform float _Color_int;
            uniform float _Alpha_Int;

            
            v2f vert(appdata_t v )
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
                float4 screenPos = ComputeScreenPos(ase_clipPos);
                OUT.ase_texcoord3 = screenPos;
                

                v.vertex.xyz +=  float3( 0, 0, 0 ) ;

                float4 vPosition = UnityObjectToClipPos(v.vertex);
                OUT.worldPosition = v.vertex;
                OUT.vertex = vPosition;

                float2 pixelSize = vPosition.w;
                pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));

                float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                float2 maskUV = (v.vertex.xy - clampedRect.xy) / (clampedRect.zw - clampedRect.xy);
                OUT.texcoord = v.texcoord;
                OUT.mask = float4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));

                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag(v2f IN ) : SV_Target
            {
                //Round up the alpha color coming from the interpolator (to 1.0/256.0 steps)
                //The incoming alpha could have numerical instability, which makes it very sensible to
                //HDR color transparency blend, when it blends with the world's texture.
                const half alphaPrecision = half(0xff);
                const half invAlphaPrecision = half(1.0/alphaPrecision);
                IN.color.a = round(IN.color.a * alphaPrecision)*invAlphaPrecision;

                float mulTime16 = _Time.y * _MainTex_Panner.z;
                float4 screenPos = IN.ase_texcoord3;
                float4 ase_screenPosNorm = screenPos / screenPos.w;
                ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
                float2 appendResult39 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
                float2 temp_output_40_0 = (appendResult39*2.0 + -1.0);
                float2 break42 = temp_output_40_0;
                float2 appendResult46 = (float2(length( temp_output_40_0 ) , (0.0 + (atan2( break42.y , break42.x ) - 0.0) * (1.0 - 0.0) / (3.141593 - 0.0))));
                float2 appendResult24 = (float2(_UVTillingOffset.x , _UVTillingOffset.y));
                float2 appendResult26 = (float2(_UVTillingOffset.z , _UVTillingOffset.w));
                float2 panner10 = ( ( mulTime16 + _MainTex_Panner.w ) * (_MainTex_Panner).xy + (appendResult46*appendResult24 + appendResult26));
                float4 tex2DNode1 = tex2D( _MainTex_001, panner10 );
                float2 uv_MaskTex_001 = IN.texcoord.xy * _MaskTex_001_ST.xy + _MaskTex_001_ST.zw;
                float4 tex2DNode2 = tex2D( _MaskTex_001, uv_MaskTex_001 );
                float4 appendResult7 = (float4(( float4( (tex2DNode1).rgb , 0.0 ) * float4( (tex2DNode2).rgb , 0.0 ) * _MainTex_Color * _Color_int ).rgb , ( ( tex2DNode1.a * tex2DNode2.a ) * _Alpha_Int )));
                

                half4 color = appendResult7;

                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.mask.xy)) * IN.mask.zw);
                color.a *= m.x * m.y;
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                color.rgb *= color.a;

                return color;
            }
        ENDCG
        }
    }
    CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19108
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;2628.755,-921.7198;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;5;2563.755,-763.7198;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;4;2565.755,-1019.72;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;2769.755,-1017.72;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;12;1645.755,-970.7198;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;1840.455,-891.8373;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;16;1649.455,-892.8373;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;19;3103.892,-1315.385;Inherit;False;253;247;Comment;2;21;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;20;3154.892,-1265.385;Inherit;False;Property;_BlendRGB_Src;BlendRGB_Src;0;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;3153.892,-1184.385;Inherit;False;Property;_BlendRGB_Dst;BlendRGB_Dst;1;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;11;1446.755,-968.7198;Inherit;False;Property;_MainTex_Panner;MainTex_Panner;5;0;Create;True;0;0;0;False;0;False;0,0,1,0;0.28,0.21,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;2574.558,-1282.052;Inherit;False;Property;_Color_int;Color_int;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;2505.558,-1208.052;Inherit;False;Property;_MainTex_Color;MainTex_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.2071022,0.245283,0.2075217,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;37;2771.558,-778.0515;Inherit;False;RGBAMultiply;-1;;5;d9074c6ae5d8f8b49943f27d04603a96;0;5;27;FLOAT4;0,0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;14;FLOAT;0;False;15;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;10;1968.776,-1153.432;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;2180.082,-1019.483;Inherit;True;Property;_MainTex_001;MainTex_001;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;2181.755,-763.7198;Inherit;True;Property;_MaskTex_001;MaskTex_001;7;0;Create;True;0;0;0;False;0;False;-1;None;2882b04ccafd0b943a4b9bfa94a65ab2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;40;44.18322,-1132.63;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;41;332.1834,-1149.63;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;42;326.1834,-1050.63;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ATan2OpNode;43;453.1833,-1051.63;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;44;590.1833,-1053.63;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.141593;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;774.1833,-1150.63;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;22;1361.558,-1147.052;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;1117.558,-1004.052;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;1121.558,-1100.052;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;23;921.5583,-1130.052;Inherit;False;Property;_UVTillingOffset;UVTillingOffset;4;0;Create;True;0;0;0;False;0;False;1,1,0,0;0.29,3,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;39;-82.81689,-1131.63;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;8;-262.8732,-1162.109;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;3373.755,-1024.72;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;3539.709,-1021.675;Float;False;True;-1;2;ASEMaterialInspector;0;3;VFXUI/2D/Screen_TX;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;3160.391,-966.9475;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;2991.391,-934.9475;Inherit;False;Property;_Alpha_Int;Alpha_Int;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
WireConnection;3;0;1;4
WireConnection;3;1;2;4
WireConnection;5;0;2;0
WireConnection;4;0;1;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;28;0
WireConnection;6;3;29;0
WireConnection;12;0;11;0
WireConnection;17;0;16;0
WireConnection;17;1;11;4
WireConnection;16;0;11;3
WireConnection;10;0;22;0
WireConnection;10;2;12;0
WireConnection;10;1;17;0
WireConnection;1;1;10;0
WireConnection;40;0;39;0
WireConnection;41;0;40;0
WireConnection;42;0;40;0
WireConnection;43;0;42;1
WireConnection;43;1;42;0
WireConnection;44;0;43;0
WireConnection;46;0;41;0
WireConnection;46;1;44;0
WireConnection;22;0;46;0
WireConnection;22;1;24;0
WireConnection;22;2;26;0
WireConnection;26;0;23;3
WireConnection;26;1;23;4
WireConnection;24;0;23;1
WireConnection;24;1;23;2
WireConnection;39;0;8;1
WireConnection;39;1;8;2
WireConnection;7;0;6;0
WireConnection;7;3;47;0
WireConnection;0;0;7;0
WireConnection;47;0;3;0
WireConnection;47;1;48;0
ASEEND*/
//CHKSM=34CD4029D025B772798527FF90A95704C03CDEF3