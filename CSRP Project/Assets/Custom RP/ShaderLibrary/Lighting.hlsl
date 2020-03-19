﻿#ifndef CUSTOM_LIGHTING_INCLUDED
#define CUSTOM_LIGHTING_INCLUDED

float3 IncomingLight (Surface surface, Light light)
{
	float NdotL = saturate(dot(surface.normal, light.direction) * light.attenuation);

	float lightIntensity = 0.01;
	if(NdotL > 0.1)
		lightIntensity = 1;

	return lightIntensity * light.color * surface.color;
}

float3 GetLighting (Surface surface, Light light) {
	return IncomingLight(surface, light);
}

float3 GetLighting (Surface surfaceWS) {
	ShadowData shadowData = GetShadowData(surfaceWS);
	float3 color = 0.0;
	for (int i = 0; i < GetDirectionalLightCount(); i++) {
		Light light = GetDirectionalLight(i, surfaceWS, shadowData);
		color += GetLighting(surfaceWS, light);
	}
	return color;
}

#endif