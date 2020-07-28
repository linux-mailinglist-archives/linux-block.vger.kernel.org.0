Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444DC231289
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgG1T3N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 15:29:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58772 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgG1T3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 15:29:12 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 798D6BFAB3;
        Tue, 28 Jul 2020 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1595964029;
        bh=4MsjiNb2T2lssCEPpGpfVFW+y6dkRjFVtW8h8+TVTfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfQmbIQYCGbNJdZ+Rd3ZdknS4sZDLl1WtWeu2gLh2KNXbDXLCAtrFAKqQAXXijIql
         tEwVYxWoJ+rULfNt8R7KwHf+3O9hEz38QiqvIdwCFNbpOYP9YRr2Mj/Eq53TYB20gs
         M+A31VWb4TM8ezuySUxFz0e0z8uoIoYRRIwWkqiFk8sAJkx0wXA/ETL9Lcub+aPJDy
         76V5DoAlW6CHcYfVR4zRzYCzK+KObh0q0QTu6hOMPMWhlIIDzZB8mYxHfszRmHgvSd
         8bQtiKtPpXcFP0zUYBvL6g/HEUK2dE8fojWQHUWMtwGrTEgJtVtrAWQZad0aNp2p6g
         hIBmDK+997Jbg==
Date:   Tue, 28 Jul 2020 21:20:28 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 4/5] zbd/005: Enable zonemode=zbd when zone
 capacity is less than zone size
Message-ID: <20200728192028.GD103177@apples.localdomain>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728101452.19309-5-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28 19:14, Shin'ichiro Kawasaki wrote:
> The test case zbd/005 runs fio to issue sequential write requests with
> high queue depth. This workload does not require zonemode=zbd for zones
> with zone capacity same as zone length. However, when the zone has
> smaller zone capacity than zone size, it issues write beyond zone
> capacity and triggers write errors.
> 
> To allow fio skipping the writes beyond zone capacity, specify the option
> zonemode=zbd to fio when the test target zone has zone capacity smaller
> than zone size.
> 
> Also remove unused sysfs access in the test case.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

