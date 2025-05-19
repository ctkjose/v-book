
{doc-type:doc;doc-version:1.0;doc-title:Azimuth}
**V Stuff** | [V.Dev](/index.html) | [Articles](./index.md)<BR>
# Azimuth  {menu:topics}


Every day we get a new programming language. Many of these languages are born out of curiosity and as a learning exercise and some set to solve real dilemmas and explore novel ideas. We have so many options and each language has its niche concepts and paradigms. Like we all know what language is the right one is a very a very project specific question and even more a very personal question. 

Sadly programming languages also build communities that become a sort of religious silos where some members feed on a notion of one language to rule everything, the superiority of their language and worst attacking everything that is not their language. **V** is yet another language competing for your attention, and more important a very young language trying to make a name for itself. In the early days of V, the V community got entangle into some internet gossip due to how some parts of the language aspects and goals were presented. You claim this and that, picking on the hyperbolic message that was use to catch attention and turning every word into a verbatim contract that was failed and some even insinuated that the language was a scam. When in actuality the history of V is no difference to any other community project.

As a young language, V is still defining itself, testing the concepts and being pragmatic about its goals. One limitation that the V community has is that everybody is still working on the language, thus communication and documentation take a back seat!

This article is a community attempt for a stop-gap solution. The **Azimuth** is written for those of you that are looking to understand the ideas behind V, the philosophy and get a sense of the language direction. 

> Disclaimer: This is not an official communication of the V-Lang Project. Please understand that this article is not a dissertation of language design or that it has methodical comparison of languages and features. Its just a collection of considerations and opinions on the V language design.


# Backends

As of 2021 the main backend of V is C. Using C as a backend frees the community to spend their resources on building the language itself. The C ecosystems brings extensive tooling and platform support. Using C is a pragmatic choice to increase platform support, generate performant binaries that are production ready. 

LLVM is another option, it is a widely used compiler infrastructure, so there's a large ecosystem of tools and libraries available. Using LLVM could at some point be an alternative for a V backend, yet using C allows us to use CLang's LLVM right now while keeping the choice for other tooling options.



# To organize....

This [discussion](https://github.com/microsoft/typescript-go/discussions/411) on MS decision to use Go for Native TypeScript brings many perspectives on topic of language ecosystem, tooling and performance. Many people like the ease of development and compatibility of Go but understand that it is not the more performant. Optimizing code generation is not trivial, could other Go backends like LLVM become the preferred backends. Their official statement on the GoLLVM project [reads](https://go.googlesource.com/gollvm) "Gollvm is intended to provide a Go compiler with a more powerful back end, enabling such benefits as better inlining, vectorization, register allocation, etc.". 

 
I like a comment posted on this [thread](https://github.com/vlang/v/discussions/7849), "C is the key ingredient of the concrete poured into the foundations of this civilization." and V seats on top of those foundations.