using UnityEngine;

/// <summary>
/// Controller for projected planar shadow material. 
/// Updates the material with shadow receiver plane data.
/// </summary>
[ExecuteInEditMode]
[RequireComponent(typeof(MeshRenderer))]
public class ProjectedPlanarShadowController : MonoBehaviour
{
    public Transform shadowReceiverPlane;

    private MeshRenderer meshRenderer;

    private void Awake()
    {
        meshRenderer = GetComponent<MeshRenderer>();
    }

    private void Update()
    {
        if (shadowReceiverPlane != null)
        {
            // Update shader's plane normal vector with plane's distance from origin
            meshRenderer.sharedMaterial.SetVector("_PlaneNormal",
               new Vector4(
                    shadowReceiverPlane.transform.up.x,
                    shadowReceiverPlane.transform.up.y,
                    shadowReceiverPlane.transform.up.z,
                    -Vector3.Dot(shadowReceiverPlane.transform.up, shadowReceiverPlane.transform.position)
               ));
        }
    }
}
