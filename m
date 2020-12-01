Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6908C2C9F3B
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgLAKaS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Dec 2020 05:30:18 -0500
Received: from fallback22.m.smailru.net ([94.100.176.132]:53266 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgLAKaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 05:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=l1N6XIAne+McdY3ijU+uuVLe1pgShwCc1+08lGmsRLI=;
        b=pQ+IOV+bVQ/rrrycnu5oR2JZ6PtMc6LMM7THJ4sd4mtEX/uteaWrP+AoYWm63PfQOSoqXfclGRoTWZyny6EUvVJJ6XwkDggDxi1uC82mQAqRzLY9GQhqDCUGfmk57L7XuGEpymJLg1T8DcB9B+lTUfW2j1s4SQRdr0mM805pCtI=;
Received: from [10.161.64.40] (port=46076 helo=smtp32.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <alekseymmm@mail.ru>)
        id 1kk2uW-00038h-0c; Tue, 01 Dec 2020 13:29:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=l1N6XIAne+McdY3ijU+uuVLe1pgShwCc1+08lGmsRLI=;
        b=W2pM13a9w6mXURaDovfJjgjfMBXZvXeE1n7RwEn6cP/WCk63Bmx+swFPfOWeP6KQwuZaIgoixxKDk7thT1n7C+WdxBaDXVllKt6Aff3GXrN2NaqfLlU35qSOLkZgsOEemPTF69HwbV5b1N7lVp34D7RXMkAgSTpinp55AHwMzTQ=;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
        id 1kk2tk-00016e-7J; Tue, 01 Dec 2020 13:28:41 +0300
Message-ID: <942255077c7caf5a2b1983570e30c3bf06410f62.camel@mail.ru>
Subject: Re: [RFC PATCH 1/2] block: add simple copy support
From:   Aleksei Marov <alekseymmm@mail.ru>
To:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, selvajove@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com
Date:   Tue, 01 Dec 2020 13:28:38 +0300
In-Reply-To: <20201201053949.143175-2-selvakuma.s1@samsung.com>
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
         <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
         <20201201053949.143175-2-selvakuma.s1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD999A8EEC2DADA0D07E1BF0C4D8F2165D6BFD1794E82424750182A05F5380850409BE7A150ED1B00F1C022DD71FCE058B8DEFA2C7AF8D1056E373E27A7D4B55752
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE782A779A89F7D69B2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE742D9BD90C58D50E0EA1F7E6F0F101C674E70A05D1297E1BBC6CDE5D1141D2B1C5EB6B0088F9EF39078F613C64E7469982E703C04DF1DF8D69FA2833FD35BB23D9E625A9149C048EE9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B524E70A05D1297E1BBF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481F9449624AB7ADAF37CEDA8D6C8C3B0531D8FC6C240DEA76428AA50765F7900637C5678F1FF88595B3D81D268191BDAD3DBD4B6F7A4D31EC0B7A15B7713DBEF166D81D268191BDAD3D78DA827A17800CE79C97E770BC796042EC76A7562686271EEC990983EF5C032935872C767BF85DA29E625A9149C048EE3F735096452955E3837C4FEFBD1860714AD6D5ED66289B524E70A05D1297E1BB35872C767BF85DA227C277FBC8AE2E8BFF03D3B3299F339D75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A58B4D0912B3BC9DA9F1391F1CF3B19E0472EB6FD1610E9A0AD59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75D299BBC8C521FD19410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC41E2768949EA6ADD8C54C4338DDBD92B00AAD22493C4BF0A8888A14071D875BB2D42BBAD9C943210154E7D1AE445192D9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEErOympIxBEhQUaV/Z7rJg==
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EABDEAF675FBD1B593B904FB4FE118C5F7AF19E46FE0E80F3EFEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C75C13076030B660F9FE9BAB5EC06FB6E4B1D0E349C464D1049FFFDB7839CE9E4A81DFF69BA5960E053F9CF25DDEF827B20617EB19EE00A32522173ACA7C4B4C
X-7FA49CB5: 0D63561A33F958A5FA959485E634EF1517ECE837C175CD85ED5283E8350AA61C8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735200AC5B80A05675ACD28451B159A507268D2E47CDBA5A96583E46DA31BAFFCCC396E0066C2D8992A164AD6D5ED66289B5278DA827A17800CE7815562577FBA2886D32BA5DBAC0009BE395957E7521B51C20B4866841D68ED3567F23339F89546C55F5C1EE8F4F765FC8A0925CD2C14BB9D75ECD9A6C639B01BBD4B6F7A4D31EC0BC0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E7354163C681A99F5D66C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F8DB212830C5B42F72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5FA959485E634EF1517ECE837C175CD8595361F0EB0C6F225D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEErOympIxBGt3PMtEqUcdQ==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005ECC5D0D0AB7E92B54B8FBEC32BC10F8EA19F082A37C6EB6F15C3726575FFF916BA06D6758C6957D0C77752E0C033A69EE9C7C6BE7440F28B4CF838113C6AC4B43453F38A29522196
X-Mras: Ok
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2020-12-01 at 11:09 +0530, SelvaKumar S wrote:
> +	ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
> +			&bio);
> +	if (!ret && bio) {
> +		ret = submit_bio_wait(bio);
> +		if (ret == -EOPNOTSUPP)
> +			ret = 0;
> +
> +		kfree(page_address(bio_first_bvec_all(bio)->bv_page) +
> +				bio_first_bvec_all(bio)->bv_offset);
> +		bio_put(bio);
> +	}
> +
> +	return ret;
> +}
I think  there is an issue here that if bio_add_page  returns error in
__blkdev_issue_copy then ret is -ENOMEM and we never do bio_put for bio
allocated in  __blkdev_issue_copy so it is small memory leak.


