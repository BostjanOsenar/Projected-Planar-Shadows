using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(MeshRenderer))]
public class MeshBlobShadowController : MonoBehaviour
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
            meshRenderer.sharedMaterial.SetVector("_PlaneNormalVectorMatrix", 
                shadowReceiverPlane.transform.worldToLocalMatrix.GetRow(1));
        }
    }

}
