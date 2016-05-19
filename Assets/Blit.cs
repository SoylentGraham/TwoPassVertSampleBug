using UnityEngine;
using System.Collections;

public class Blit : MonoBehaviour {

	public Material BlitMaterial;
	public RenderTexture Target0;
	public RenderTexture Target1;

	void Update () {

		Graphics.Blit(null, Target0, BlitMaterial, 0);
		BlitMaterial.SetTexture("xxx", Target0);
		Graphics.Blit(null, Target1, BlitMaterial, 1);
	
	}
}
