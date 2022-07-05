Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC3566133
	for <lists+linux-block@lfdr.de>; Tue,  5 Jul 2022 04:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiGEC2R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Jul 2022 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiGEC2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:28:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CCC1276D
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988093; x=1688524093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oujryl2JYvHnAVojZbyiRWiHZBohIpbls4AWqzG/w5c=;
  b=cY4pPUaWxd95wXtubnW8ijpIAPEhM9NuXHc3J1ONMfc2LENaFkRhLqVW
   7lZDRb1nEiCJJuKvQ1CarkOGxnRiiXQAOMvt5P0P2G7EOlsZWUTlY1HpP
   nrPbNQmS7G6qucjcMENVsT+ecObxIIRx/qQCddereHzMvTB5orde0ceD0
   tISYmS/wyEh2r+1w65TLEPCfPLfP4fgNsOIidfdWqUjtRyOebN8gc8tHb
   FQBjajp2Pip940E7GnIjW1FQdIhSminvGpkP1MZD0m7fG6kz9+NuZNoQo
   8mDLeh5k4hrs8RoVHwg3xEvOhrE6p99MtZAHCMSjt7Zutca6dQA4rFduF
   g==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205518842"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:28:12 +0800
IronPort-SDR: +b563M8rGedZDPmSAMPfwBRKuw1y8BSIoxfGffyNSjGbsVMuKdUZlbPeYLKFX2DhsoTQf3rTiR
 S5MRHnRAN6wAvJqd2NYIFTrJw2+X+J2Tu7N8HrX5Wxmv5QCZxL1CM6NZbGEzwmerzuE7UGCE/I
 5nBDI9i1+TgArPNypGi2CcRdEMHLAmXPtJbmzc8iYLBwPoML0V6k0h4lHsUPHarEq7uf0gMPUK
 oJQ570VAmYQrXWw/Nk08jt6NDPl5QU2TRE6WWHpeITVy0+QVf1Vr2D9QvzZYH66Ocw/qMo5sC7
 V/rHcWpzk+ZAOipP8dcwKX8n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:45:31 -0700
IronPort-SDR: kDQF5wI7j85fNJxAJaF4aFu0N3yUkWv+xRJymLVNpI4a0JaU5zLgzUKSGOuRlviUhUXdpDpNXE
 TM5Lm2FLoiqutZi24HEga1aMIuuRnjsS9D59YAnMr1cVAcoLLG8yYzd36XJYI0M4WCLSo1qwuy
 1qpKpialua90JCxwEPX+FVUom25mv9bwA7pJ7u3miNUFcNkfg7ohyCZmSOcIuEbkKScWNvPfQZ
 ISfdIFmbSJ2k/7gbwqEENDbC4nRxk87CFxfZrNB6La55w7xuxw3hC7rHYPQZ0xd/LksvuepmRr
 z2g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:28:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRRc1TDWz1Rw4L
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:28:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656988091; x=1659580092; bh=oujryl2JYvHnAVojZbyiRWiHZBohIpbls4A
        WqzG/w5c=; b=MlmPdXXBw3KWQg49di3thwWA6q10X1WR8jTcc0nFg/o32uwvo4c
        QfUr2hXZ74+GvE3lfAA0yNFuI6WsLsL6cwZH2GVv7OcBt9lXRdafmuhsrhl7fsyq
        hlbh9HMJ0OcGnbuN+fj7cErOlYcE+JU12Oex1l7/O5MhZLO4+n3sDsPrT7UG4Uiz
        ex9HzLHP6bZcOwMkyxec8iI9d8m0J/puIwhR/J6B2WGIKwLgIHkzHQy0Q2YPsmqI
        TKtmmrgn2fJ0OPHsVGYxcBJAo3TaRbywsW9Fepr27IyGEH+M0qxCWtTjKIBB+qZF
        ttcVuJwtRzPe6RHmuiNhDaY+oLCpJ5BODPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FxzQCeCarxNB for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:28:11 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRRb080Dz1RtVk;
        Mon,  4 Jul 2022 19:28:10 -0700 (PDT)
Message-ID: <7424fcbe-ebca-96c4-0236-211e0e44894b@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:28:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/17] block: use bdev_is_zoned instead of open coding it
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-4-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Use bdev_is_zoned in all places where a block_device is available instead
> of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

